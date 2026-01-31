const db = require('../../config/database');

const changeName = async (req, res) => {
    const { newUsername } = req.body;
    const cleanUsername = newUsername?.trim().toLowerCase();

    if (!cleanUsername || cleanUsername.length < 3 || cleanUsername.length > 20) {
        return res.status(400).json({ message: 'Username must be between 3 and 20 characters' });
    }

    const usernameRegex = /^[a-zA-Z0-9_-]+$/;
    if (!usernameRegex.test(cleanUsername)) {
        return res.status(400).json({ message: 'Username contains invalid characters. Only letters, numbers, _ and - are allowed.' });
    }

    try {
        const userResult = await db.query(
            'SELECT last_username_change FROM users WHERE userid = $1',
            [req.user.userid]
        );

        if (userResult.rows.length === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        const lastChange = userResult.rows[0].last_username_change;

        const now = new Date();
        const cooldown = 14 * 24 * 60 * 60 * 1000;

        if (lastChange && now - new Date(lastChange) < cooldown) {
            return res.status(400).json({ message: 'You can only change your username once every 14 days' });
        }

        const result = await db.query(
            'UPDATE users SET username = $1, last_username_change = NOW() WHERE userid = $2 RETURNING userid, username',
            [cleanUsername, req.user.userid]
        );

        const user = result.rows[0];

        return res.status(200).json({
            message: 'Username updated!',
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