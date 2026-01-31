// controllers/refresh.js
const jwt = require("jsonwebtoken");
const redis = require("../../config/redis");
const { createAccessToken, createRefreshToken } = require("../../utils/tokens");

const refresh = async (req, res) => {
    const { refreshToken } = req.body;
    if (!refreshToken) return res.sendStatus(401);

    try {
        const decoded = jwt.verify(refreshToken, process.env.REFRESH_SECRET);

        if (decoded.type !== "refresh") return res.sendStatus(403);

        const exists = await redis.get(`refresh:${decoded.tokenId}`);

        if (!exists) {
            const keys = await redis.keys(`refresh:*`);
            for (const key of keys) {
                if ((await redis.get(key)) === decoded.userid) {
                    await redis.del(key);
                }
            }
            return res.status(403).json({ error: "Token reuse detected - all sessions revoked" });
        }


        await redis.del(`refresh:${decoded.tokenId}`);

        const accessToken = createAccessToken({ userid: decoded.userid, role: decoded.role });

        const { token: newRefresh, tokenId: newTokenId } =
            createRefreshToken(decoded.userid, decoded.role);

        await redis.set(
            `refresh:${newTokenId}`,
            decoded.userid,
            "EX",
            60 * 60 * 24 * 30
        );

        res.json({
            accessToken,
            refreshToken: newRefresh
        });
    } catch (err) {
        return res.sendStatus(403);
    }
};

module.exports = refresh;