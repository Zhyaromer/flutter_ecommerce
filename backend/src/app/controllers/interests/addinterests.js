const db = require('../../config/database');

const addInterests = async (req, res) => {
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
            `INSERT INTO user_category_preferences (userid, categoryid) 
             VALUES ($1, $2)`,
            [userId, categoryId]
        );

        if (result.rowCount === 0) {
            return res.status(500).json({
                success: false,
                error: 'Failed to add interest'
            });
        }

        return res.status(201).json({
            success: true,
            message: 'Interest added successfully'
        });
    } catch (error) {
        return res.status(500).json({
            success: false,
            error: 'Internal server error'
        });
    }
}

module.exports = addInterests;