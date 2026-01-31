// controllers/authController.js
const bcrypt = require('bcrypt');
const db = require('../../config/database');
const redis = require('../../config/redis');
const { createAccessToken, createRefreshToken } = require('../../utils/tokens');
require('dotenv').config();

const login = async (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ error: 'Email and password are required' });
    }

    if (!/\S+@\S+\.\S+/.test(email)) {
        return res.status(400).json({ error: 'Invalid email format' });
    }

    if (password.length < 8) {
        return res.status(400).json({ error: 'Password must be at least 8 characters' });
    }

    try {
        const result = await db.query(`
            SELECT u.userid, u.username, u.password, ur.role
            FROM users u
            LEFT JOIN user_roles ur ON u.userid = ur.userid
            WHERE u.email = $1
        `, [email.trim().toLowerCase()]);

        if (result.rows.length === 0) {
            return res.status(400).json({ error: 'Invalid credentials' });
        }

        const user = result.rows[0];

        const validPassword = await bcrypt.compare(password, user.password);
        if (!validPassword) {
            return res.status(400).json({ error: 'Invalid credentials' });
        }

        if (!user.role) {
            return res.status(400).json({ error: 'User role not found' });
        }

        const accessToken = createAccessToken({
            userid: user.userid,
            role: user.role
        });

        const { token: refreshToken, tokenId } = createRefreshToken(user.userid, user.role);

        await redis.set(
            `refresh:${tokenId}`,
            user.userid,
            "EX",
            60 * 60 * 24 * 30 // 30 days
        );

        res.status(200).json({
            user: {
                userid: user.userid,
                username: user.username,
                role: user.role
            },
            accessToken,
            refreshToken
        });

    } catch (err) {
        console.error('Login error:', err);
        res.status(500).json({ error: 'Server error' });
    }
};

module.exports = login;