const db = require('../../config/database');

const editAddress = async (req, res) => {
    const userId = req.user.userid;
    const { addressid } = req.params;
    const { label, address_line, city, phone_number } = req.body;

    if (!addressid || isNaN(addressid)) {
        return res.status(400).json({
            success: false,
            error: 'Valid address ID is required'
        });
    }

    if (!address_line && !city && !label && !phone_number) {
        return res.status(400).json({
            success: false,
            error: 'At least one field must be provided to update'
        });
    }

    if (address_line && address_line.length > 100) {
        return res.status(400).json({
            success: false,
            error: 'Address line must not exceed 100 characters'
        });
    }

    if (city && city.length > 50) {
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

    if (phone_number && phone_number.length > 20) {
        return res.status(400).json({
            success: false,
            error: 'Phone number must not exceed 20 characters'
        });
    }

    const client = await db.connect();

    try {
        await client.query('BEGIN');

        const checkResult = await client.query(
            'SELECT addressid FROM user_addresses WHERE addressid = $1 AND userid = $2',
            [addressid, userId]
        );

        if (checkResult.rows.length === 0) {
            await client.query('ROLLBACK');
            return res.status(404).json({
                success: false,
                error: 'Address not found or does not belong to you'
            });
        }

        const updates = [];
        const values = [];
        let paramCount = 1;

        if (label !== undefined) {
            updates.push(`label = $${paramCount}`);
            values.push(label || null);
            paramCount++;
        }
        if (address_line !== undefined) {
            updates.push(`address_line = $${paramCount}`);
            values.push(address_line.trim());
            paramCount++;
        }
        if (city !== undefined) {
            updates.push(`city = $${paramCount}`);
            values.push(city.trim());
            paramCount++;
        }
        if (phone_number !== undefined) {
            updates.push(`phone_number = $${paramCount}`);
            values.push(phone_number || null);
            paramCount++;
        }

        values.push(addressid, userId);

        if (updates.length === 0) {
            return res.status(400).json({ error: "No fields to update" });
        }

        const updateQuery = `
            UPDATE user_addresses 
            SET ${updates.join(', ')} 
            WHERE addressid = $${paramCount} AND userid = $${paramCount + 1}
            RETURNING addressid`;

        const result = await client.query(updateQuery, values);

        await client.query('COMMIT');

        return res.status(200).json({
            success: true,
            message: 'Address updated successfully',
            addressid: result.rows[0].addressid
        });
    } catch (error) {
        await client.query('ROLLBACK');
        return res.status(500).json({
            success: false,
            error: 'Failed to update address'
        });
    } finally {
        client.release();
    }
};

module.exports = editAddress;
