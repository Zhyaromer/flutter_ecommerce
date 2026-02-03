const db = require('../../config/database');

const getAllInterests = async (req, res) => {
    try {
        const result = await db.query(
            `select categoryid,name from categories`
        );

        if (result.rows.length === 0) {
            return res.status(404).json({
                success: false,
                error: 'No interests found'
            });
        }

        return res.status(200).json({
            success: true,
            data: result.rows
        });
    } catch (error) {
        return res.status(500).json({
            success: false,
            error: 'Internal server error'
        });
    }
}

module.exports = getAllInterests;