const db = require('../../config/database');

const getUserInterests = async (req, res) => {
    const userId = req.user.userid;

    if (!userId) {
        return res.status(400).json({
            success: false,
            error: 'User ID is required'
        });
    }

    try {
        const result = await db.query(
            `SELECT c.categoryid , c.name 
             FROM user_category_preferences ucp
             JOIN categories c ON ucp.categoryid = c.categoryid
             WHERE ucp.userid = $1`,
            [req.user.userid]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({
                success: false,
                error: 'No interests found for the user'
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

module.exports = getUserInterests;