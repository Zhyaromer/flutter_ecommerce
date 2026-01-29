// controllers/authController.js
const bcrypt = require('bcrypt');
const db = require('../config/database'); // your DB connection
const jwt = require('jsonwebtoken');

const SECRET_KEY = 'your_super_secret_key';
const TOKEN_EXPIRE = '30d';

const signup = async (req, res) => {
    const { username, email, password } = req.body;

    if (!username || !email || !password) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    if (password.length <= 8) {
        return res.status(400).json({ error: 'Password must be at least 8 characters' });
    }

    if (!/\S+@\S+\.\S+/.test(email)) {
        return res.status(400).json({ error: 'Invalid email format' });
    }

    if (username.length < 3 || username.length > 30) {
        return res.status(400).json({ error: 'Username must be between 3 and 30 characters' });
    }

    try {

        const userExists = await db.query('SELECT * FROM users WHERE email = $1', [email]);

        if (userExists.rows.length > 0) {
            return res.status(400).json({ error: 'Email already in use' });
        }

        const usernameExists = await db.query('SELECT * FROM users WHERE username = $1', [username]);

        if (usernameExists.rows.length > 0) {
            return res.status(400).json({ error: 'Username already in use' });
        }

        if (password.toLowerCase().includes(username.toLowerCase())) {
            return res.status(400).json({ error: 'Password should not contain the username' });
        }

        if (password.toLowerCase().includes(email.toLowerCase().split('@')[0])) {
            return res.status(400).json({ error: 'Password should not contain the email local part' });
        }

        const salt = await bcrypt.genSalt(10);

        const hashedPassword = await bcrypt.hash(password, salt);

        const result = await db.query(
            'INSERT INTO users (username, email, password) VALUES ($1, $2, $3) RETURNING *',
            [username, email, hashedPassword]
        );

        const user = result.rows[0];

        const token = jwt.sign({ userid: user.userid }, SECRET_KEY, { expiresIn: TOKEN_EXPIRE });

        res.status(201).json({ user: { userid: user.userid, username: user.username, email: user.email }, token });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
};

module.exports = signup;
