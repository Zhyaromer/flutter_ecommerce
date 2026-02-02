const db = require('../../config/database');

const addAddress = async (req, res) => {
    const userId = req.user.userid;
    const { label, address_line, city, phone_number } = req.body;

    if (!address_line || !city) {
        return res.status(400).json({
            success: false,
            error: 'Address line and city are required'
        });
    }

    if (address_line.length > 100) {
        return res.status(400).json({
            success: false,
            error: 'Address line must not exceed 100 characters'
        });
    }

    if (city.length > 50) {
        return res.status(400).json({
            success: false,
            error: 'City must not exceed 50 characters'
        });
    }

    if (label && label.length > 50) {
        return res.status(400).json({
            success: false,
            error: 'Label must not exceed 50 characters'
        });
    }

    if (phone_number && phone_number.length > 11) {
        return res.status(400).json({
            success: false,
            error: 'Phone number must not exceed 11 characters'
        });
    }

    if (!/^(07[3-9]\d{8})$/.test(phone_number)) {
        return res.status(400).json({ error: "Invalid Iraqi phone number format" });
    }

    try {
        const result = await db.query(
            `INSERT INTO user_addresses (userid, label, address_line, city, phone_number) 
             VALUES ($1, $2, $3, $4, $5) 
             RETURNING addressid`,
            [userId, label || null, address_line.trim(), city.trim(), phone_number || null]
        );

        if (result.rows.length === 0) {
            return res.status(500).json({
                success: false,
                error: 'Failed to add address'
            });
        }

        return res.status(201).json({
            success: true,
            message: 'Address added successfully',
            addressid: result.rows[0].addressid
        });
    } catch (error) {
        return res.status(500).json({
            success: false,
            error: 'Failed to add address'
        });
    }
};

module.exports = addAddress;
