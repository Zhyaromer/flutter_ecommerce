const bcrypt = require('bcrypt');
const db = require('../../config/database');
const redis = require('../../config/redis');
const { createAccessToken, createRefreshToken } = require('../../utils/tokens');
require('dotenv').config();

const vendorSignup = async (req, res) => {
    const { username, email, password, description, cover_image, avatar_image, location, phoneNumber, vendor_social, vendor_categoryid } = req.body;

    if (!username || !email || !password || !description || !vendor_categoryid || !phoneNumber || !avatar_image) {
        return res.status(400).json({ error: 'Missing required fields' });
    }

    if (!location || !location.city || !location.address || !Array.isArray(location)) {
        return res.status(400).json({ error: "Location, city, and address are required." });
    }

    if (!/\S+@\S+\.\S+/.test(email)) {
        return res.status(400).json({ error: 'Invalid email format' });
    }

    if (password.length < 8) {
        return res.status(400).json({ error: 'Password must be at least 8 characters' });
    }

    if (password.toLowerCase().includes(username.toLowerCase())) {
        return res.status(400).json({ error: 'Password should not contain the username' });
    }

    if (password.toLowerCase().includes(email.toLowerCase().split('@')[0])) {
        return res.status(400).json({ error: 'Password should not contain the email local part' });
    }

    if (!/^\d{10}$/.test(phoneNumber)) {
        return res.status(400).json({ error: 'Invalid phone number format' });
    }

    if (username.length > 60 || username.length <= 5) {
        return res.status(400).json({ error: 'Username must be between 6 and 60 characters' });
    }

    if (description.length > 100 || description.length <= 10) {
        return res.status(400).json({ error: 'Description must be between 10 and 100 characters' });
    }

    const client = await db.connect();

    try {
        await client.query('BEGIN');

        await client.query(
            'SELECT email , username FROM users WHERE email = $1',
            [email.trim().toLowerCase(), username.trim().toLowerCase()]
        );

        await client.query(
            'SELECT email , username FROM vendor WHERE email = $1',
            [email.trim().toLowerCase(), username.trim().toLowerCase()]
        );

        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password.trim(), salt);

        const insertVendorQuery = 'insert into vendor (username, email, password, description, cover_image, avatar_image, category) values ($1, $2, $3, $4, $5, $6, $7) RETURNING id, username, email';
        const categoryResult = await client.query('SELECT categoryid FROM categories WHERE name = $1', [vendor_categoryid.trim()]);

        if (categoryResult.rowCount === 0) {
            await client.query('ROLLBACK');
            return res.status(400).json({ error: 'Invalid category' });
        }

        const categoryId = categoryResult.rows[0].vendor_categoryid;

        const vendorResult = await client.query(insertVendorQuery, [
            username.trim(),
            email.trim().toLowerCase(),
            hashedPassword,
            description.trim(),
            cover_image || null,
            avatar_image,
            categoryId
        ]);

        const vendor = vendorResult.rows[0];

        if (!vendor) {
            await client.query('ROLLBACK');
            return res.status(500).json({ error: 'Failed to create vendor' });
        }

        const insertVendorLocation = 'INSERT INTO vendor_location (vendor_id, location) VALUES ($1, $2)';

        for (const loc of location) {
            const { city, address } = loc;
            const locResult = await client.query(insertVendorLocation, [vendor.id, { city, address }]);

            if (locResult.rowCount === 0) {
                await client.query('ROLLBACK');
                return res.status(500).json({ error: 'Failed to add vendor location' });
            }
        }

        const insertVendorContact = 'INSERT INTO vendor_contact (vendor_id, phone_number) VALUES ($1, $2)';

        for (const phone of phoneNumber) {
            const contactResult = await client.query(insertVendorContact, [vendor.id, phone]);
            if (contactResult.rowCount === 0) {
                await client.query('ROLLBACK');
                return res.status(500).json({ error: 'Failed to add vendor contact' });
            }
        }

        if (vendor_social && typeof vendor_social === 'object') {
            const insertVendorSocial = 'INSERT INTO vendor_social (vendor_id, name, social_link) VALUES ($1, $2, $3)';

            for (const social in vendor_social) {
                const { name, social_link } = social;

                const socialResult = await client.query(insertVendorSocial, [vendor.id, name, social_link]);

                if (socialResult.rowCount === 0) {
                    await client.query('ROLLBACK');
                    return res.status(500).json({ error: 'Failed to add vendor social link' });
                }
            }
        }

        await client.query('COMMIT');
        res.status(201).json({ message: 'Vendor created successfully', vendor });
    } catch (error) {
        console.log(error);
        if (error.code === '23505') {
            return res.status(400).json({ message: 'Username or email is already taken' });
        }
        console.error('Error during vendor signup:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

module.exports = vendorSignup;