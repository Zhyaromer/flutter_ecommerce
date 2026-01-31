const db = require('../../config/database');
const jwt = require('jsonwebtoken');
const redis = require("../../config/redis");

const changeName = async (req, res) => {
    const { newUsername } = req.body;
    const cleanUsername = newUsername?.trim();

    if (!cleanUsername || cleanUsername.length < 3 || cleanUsername.length > 20) {
        return res.status(400).json({ message: 'Username must be between 3 and 20 characters' });
    }

    if (cleanUsername === req.user.username) {
        return res.status(400).json({ message: 'This is already your current username' });
    }

    try {
        const result = await db.query(
            'UPDATE users SET username = $1 WHERE userid = $2 RETURNING userid, username',
            [cleanUsername, req.user.userid]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        const user = result.rows[0];
        const oldToken = req.headers.authorization.split(' ')[1];
        const now = Math.floor(Date.now() / 1000);
        const timeLeft = req.user.exp - now;

        const expiry = timeLeft > 0 ? timeLeft : 1;

        const newToken = jwt.sign(
            {
                userid: user.userid,
                username: user.username,
                role: req.user.role
            },
            process.env.SECRET_KEY,
            { expiresIn: expiry }
        );

        try {
            if (timeLeft > 0) {
                await redis.set(oldToken, 'invalidated', 'EX', expiry);
            }
        } catch (redisError) {
            console.error('Redis Blacklist Failed (non-critical):', redisError.message);
        }

        return res.status(200).json({
            message: 'Username updated!',
            token: newToken,
            username: user.username
        });

    } catch (error) {
        if (error.code === '23505') {
            return res.status(400).json({ message: 'Username is already taken' });
        }
        console.error('Critical Error in changeName:', error);
        return res.status(500).json({ message: 'Server error' });
    }
}

module.exports = changeName;