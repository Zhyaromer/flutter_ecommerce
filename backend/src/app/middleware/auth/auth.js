// middleware/auth/auth.js
const jwt = require("jsonwebtoken");

const auth = (roles = []) => {
    if (typeof roles === "string") roles = [roles];

    return (req, res, next) => {
        const authHeader = req.headers.authorization;
        if (!authHeader?.startsWith("Bearer ")) {
            return res.sendStatus(401);
        }

        const token = authHeader.split(" ")[1];

        try {
            const decoded = jwt.verify(token, process.env.ACCESS_SECRET);

            if (decoded.type !== "access") return res.sendStatus(403);

            if (roles.length && !roles.includes(decoded.role))
                return res.sendStatus(403);

            req.user = decoded;
            next();
        } catch {
            res.sendStatus(401);
        }
    };
};

module.exports = auth;
