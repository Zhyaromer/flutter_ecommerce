// utils/tokens.js
const jwt = require("jsonwebtoken");
const { v4: uuidv4 } = require("uuid");

const createAccessToken = (user) => {
    return jwt.sign(
        { userid: user.userid, role: user.role, type: "access" },
        process.env.ACCESS_SECRET,
        { expiresIn: process.env.ACCESS_EXPIRE }
    );
};

const createRefreshToken = (userid, role) => {
    const tokenId = uuidv4();

    const token = jwt.sign(
        { userid, role, tokenId, type: "refresh" },
        process.env.REFRESH_SECRET,
        { expiresIn: process.env.REFRESH_EXPIRE }
    );

    return { token, tokenId };
};

module.exports = {
    createAccessToken,
    createRefreshToken,
};
