const db = require('../../config/database');

const deleteInterests = async (req, res) => {
    const userId = req.user.userid;
    const { categoryId } = req.body;

    if (!userId) {
        return res.status(400).json({
            success: false,
            error: 'User ID is required'
        });
    }

    if (!categoryId) {
        return res.status(400).json({
            success: false,
            error: 'Category ID is required'
        });
    }

    try {
        const result = await db.query(
            `DELETE FROM user_category_preferences 
             WHERE userid = $1 AND categoryid = $2`,
            [userId, categoryId]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({
                success: false,
                error: 'Interest not found for the user'
            });
        }

        return res.status(200).json({
            success: true,
            message: 'Interest deleted successfully'
        });
    } catch (error) {
        return res.status(500).json({
            success: false,
            error: 'Internal server error'
        });
    }
}

module.exports = deleteInterests;