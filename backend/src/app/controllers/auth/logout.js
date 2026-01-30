const jwt = require("jsonwebtoken");
const redis = require("../../config/redis");

const logout = async (req, res) => {
    const authHeader = req.headers.authorization;
    if (!authHeader?.startsWith("Bearer ")) {
        return res.status(401).json({ error: "No token" });
    }

    const token = authHeader.split(" ")[1];

    const decoded = jwt.decode(token);
    const now = Math.floor(Date.now() / 1000);
    const exp = decoded?.exp || now;

    const ttl = exp - now;
    if (ttl <= 0) return res.status(400).json({ error: "Token already expired" });

    await redis.set(token, "blacklisted", "EX", ttl);

    res.json({ message: "Logged out" });
};

module.exports = logout;
