const db = require('../../config/database');

const saveInterests = async (req, res) => {
    const userId = req.user.userid;
    const { categoryIds } = req.body;

    if (!userId) {
        return res.status(400).json({
            success: false,
            error: 'User ID is required'
        });
    }

    if (!Array.isArray(categoryIds) || categoryIds.length === 0) {
        return res.status(400).json({
            success: false,
            error: 'Category IDs must be a non-empty array'
        });
    }

    try {
        const insertValues = categoryIds.map((_, index) => `($1, $${index + 2})`).join(', ');
        const queryParams = [userId, ...categoryIds];

        const result = await db.query(
            `INSERT INTO user_category_preferences (userid, categoryid) 
             VALUES ${insertValues}
             ON CONFLICT (userid, categoryid) DO NOTHING`,
            queryParams
        );

        if (result.rowCount === 0) {
            return res.status(500).json({
                success: false,
                error: 'Failed to save interests'
            });
        }

        return res.status(200).json({
            success: true,
            message: 'Interests saved successfully'
        });
    } catch (error) {
        return res.status(500).json({
            success: false,
            error: 'Internal server error'
        });
    }
}

module.exports = saveInterests;