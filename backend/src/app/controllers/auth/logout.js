// controllers/logout.js
const jwt = require("jsonwebtoken");
const redis = require("../../config/redis");

const logout = async (req, res) => {
    const { refreshToken } = req.body;

    if (!refreshToken) return res.sendStatus(204);

    try {
        const decoded = jwt.decode(refreshToken);

        if (decoded?.tokenId) {
            await redis.del(`refresh:${decoded.tokenId}`);
            return res.sendStatus(204);
        } else {
            return res.sendStatus(204);
        }
    } catch {
        return res.sendStatus(204);
    }
};

module.exports = logout;