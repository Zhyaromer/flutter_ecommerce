const db = require('../../config/database');

const getAddresses = async (req, res) => {
    const userId = req.user.userid;

    if (!userId) {
        return res.status(400).json({
            success: false,
            error: 'User ID is required'
        });
    }

    try {
        const result = await db.query(
            `SELECT addressid, userid, label, address_line, city, phone_number, created_at 
             FROM user_addresses 
             WHERE userid = $1 
             ORDER BY created_at DESC`,
            [userId]
        );

        return res.status(200).json({
            success: true,
            addresses: result.rows
        });
    } catch (error) {
        console.error('Error fetching addresses:', error);
        return res.status(500).json({
            success: false,
            error: 'Failed to fetch addresses'
        });
    }
};

module.exports = getAddresses;
