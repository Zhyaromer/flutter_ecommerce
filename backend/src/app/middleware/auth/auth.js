// middleware/auth.js
const jwt = require('jsonwebtoken');
require('dotenv').config();

const auth = (req, res, next) => {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({ error: 'No token provided' });
    }

    console.log('Auth Header:', authHeader);

    const token = authHeader.split(' ')[1];

    console.log('Extracted Token:', token);

    try {
        const decoded = jwt.verify(token, process.env.SECRET_KEY);

        if (!decoded) {
            return res.status(401).json({ error: 'Invalid token' });
        }

        req.user = decoded;
        next();
    } catch (err) {
        return res.status(401).json({ error: 'Invalid token' });
    }
};

module.exports = auth;