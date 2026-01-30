// middleware/auth.js
const jwt = require('jsonwebtoken');
const redis = require("../../config/redis");
require('dotenv').config();

const auth = (allowedRoles = []) => {
    if (typeof allowedRoles === 'string') {
        allowedRoles = [allowedRoles];
    }

    return async (req, res, next) => {
        const authHeader = req.headers.authorization;

        const blacklisted = await redis.get(authHeader?.split(' ')[1]);

        if (blacklisted) {
            return res.status(401).json({ error: 'Token is invalidated' });
        }

        if (!authHeader || !authHeader.startsWith('Bearer ')) {
            return res.status(401).json({ error: 'No token provided' });
        }

        const token = authHeader.split(' ')[1];

        try {
            const decoded = jwt.verify(token, process.env.SECRET_KEY);

            if (!decoded) {
                return res.status(401).json({ error: 'Invalid token' });
            }

            req.user = decoded;

            if (allowedRoles.length && !allowedRoles.includes(decoded.role)) {
                return res.status(403).json({ error: 'Access denied: insufficient permissions' });
            }

            next();
        } catch (err) {
            return res.status(401).json({ error: 'Invalid or expired token' });
        }
    };
};

module.exports = auth;