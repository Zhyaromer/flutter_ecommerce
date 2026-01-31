// controllers/authController.js
const bcrypt = require('bcrypt');
const db = require('../../config/database');
const redis = require('../../config/redis');
const { createAccessToken, createRefreshToken } = require('../../utils/tokens');
require('dotenv').config();

const signup = async (req, res) => {
    const { username, email, password, role } = req.body;

    if (!username || !email || !password || !role) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    if (password.length < 8) {
        return res.status(400).json({ error: 'Password must be at least 8 characters' });
    }

    if (!/\S+@\S+\.\S+/.test(email)) {
        return res.status(400).json({ error: 'Invalid email format' });
    }

    if (username.length < 3 || username.length > 30) {
        return res.status(400).json({ error: 'Username must be between 3 and 30 characters' });
    }

    if (!['shopper', 'vendor'].includes(role)) {
        return res.status(400).json({ error: 'Invalid role specified' });
    }

    if (password.toLowerCase().includes(username.toLowerCase())) {
        return res.status(400).json({ error: 'Password should not contain the username' });
    }

    if (password.toLowerCase().includes(email.toLowerCase().split('@')[0])) {
        return res.status(400).json({ error: 'Password should not contain the email local part' });
    }

    const client = await db.connect();

    try {
        await client.query('BEGIN');

        const existingUser = await client.query(
            'SELECT email, username FROM users WHERE email = $1 OR username = $2',
            [email.trim().toLowerCase(), username.trim()]
        );

        if (existingUser.rows.some(u => u.email === email.trim().toLowerCase())) {
            await client.query('ROLLBACK');
            return res.status(400).json({ error: 'Email already in use' });
        }

        if (existingUser.rows.some(u => u.username === username.trim())) {
            await client.query('ROLLBACK');
            return res.status(400).json({ error: 'Username already in use' });
        }

        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password.trim(), salt);

        const result = await client.query(
            'INSERT INTO users (username, email, password) VALUES ($1, $2, $3) RETURNING userid, username',
            [username.trim(), email.trim().toLowerCase(), hashedPassword]
        );

        if (!result.rows.length) {
            await client.query('ROLLBACK');
            return res.status(500).json({ error: 'User creation failed' });
        }

        const rolesResult = await client.query(
            'INSERT INTO user_roles (userid, role) VALUES ($1, $2) RETURNING role',
            [result.rows[0].userid, role]
        );

        if (!rolesResult.rows.length) {
            await client.query('ROLLBACK');
            return res.status(500).json({ error: 'Assigning role failed' });
        }

        await client.query('COMMIT');

        const user = result.rows[0];
        const userRole = rolesResult.rows[0].role;

        const accessToken = createAccessToken({
            userid: user.userid,
            role: userRole
        });

        const { token: refreshToken, tokenId } = createRefreshToken(user.userid, userRole);

        await redis.set(
            `refresh:${tokenId}`,
            user.userid,
            "EX",
            60 * 60 * 24 * 30 // 30 days
        );

        res.status(201).json({
            user: {
                userid: user.userid,
                username: user.username,
                role: userRole
            },
            accessToken,
            refreshToken
        });

    } catch (err) {
        await client.query('ROLLBACK');
        console.error('Signup error:', err);
        res.status(500).json({ error: 'Server error' });
    } finally {
        client.release();
    }
};

module.exports = signup;