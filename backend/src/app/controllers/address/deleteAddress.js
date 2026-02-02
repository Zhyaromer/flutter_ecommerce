const db = require('../../config/database');

const deleteAddress = async (req, res) => {
    const userId = req.user.userid;
    const { addressid } = req.params;

    if (!addressid || isNaN(addressid)) {
        return res.status(400).json({
            success: false,
            error: 'Valid address ID is required'
        });
    }

    try {
        const result = await db.query(
            'DELETE FROM user_addresses WHERE addressid = $1 AND userid = $2 RETURNING addressid',
            [addressid, userId]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({
                success: false,
                error: 'Address not found or does not belong to you'
            });
        }

        return res.status(200).json({
            success: true,
            message: 'Address deleted successfully',
            addressid: result.rows[0].addressid
        });
    } catch (error) {
        return res.status(500).json({
            success: false,
            error: 'Failed to delete address'
        });
    }
};

module.exports = deleteAddress;
