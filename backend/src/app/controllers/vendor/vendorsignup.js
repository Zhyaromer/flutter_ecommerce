const bcrypt = require('bcrypt');
const db = require('../../config/database');

const vendorSignup = async (req, res) => {
    const { username, email, password, description, cover_image, avatar_image, location, phoneNumber, vendor_social, vendor_categoryid } = req.body;

    if (!username || !email || !password || !description || !vendor_categoryid || !phoneNumber || !avatar_image) {
        return res.status(400).json({ error: 'Missing required fields' });
    }

    if (!Array.isArray(location) || location.length === 0) {
        return res.status(400).json({ error: "Location must be a non-empty array" });
    }

    for (const loc of location) {
        if (!loc.city || !loc.address) {
            return res.status(400).json({ error: "Each location must have city and address" });
        }
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

    if (!Array.isArray(phoneNumber) || phoneNumber.length === 0) {
        return res.status(400).json({ error: "phoneNumber must be an array" });
    }

    for (const phone of phoneNumber) {
        if (!/^(07[3-9]\d{8})$/.test(phone)) {
            return res.status(400).json({ error: "Invalid Iraqi phone number format" });
        }
    }

    if (phoneNumber.length > 3) {
        return res.status(400).json({ error: 'A maximum of 3 phone numbers are allowed' });
    }

    if (username.length > 60 || username.length <= 5) {
        return res.status(400).json({ error: 'Username must be between 6 and 60 characters' });
    }

    if (description.length > 200 || description.length <= 10) {
        return res.status(400).json({ error: 'Description must be between 10 and 200 characters' });
    }

    const client = await db.connect();

    try {
        await client.query('BEGIN');

        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password.trim(), salt);

        const insertVendorQuery = 'insert into vendor (username, email, password, description, cover_image, avatar_image, vendor_categoryid) values ($1, $2, $3, $4, $5, $6, $7) RETURNING vendorid, username, email';
        const categoryResult = await client.query('SELECT vendor_categoryid FROM vendor_category WHERE vendor_categoryid = $1', [vendor_categoryid]);

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

        const insertVendorLocation = 'INSERT INTO vendor_location (vendorid, city, address) VALUES ($1, $2, $3)';

        for (const loc of location) {
            const { city, address } = loc;
            const locResult = await client.query(insertVendorLocation, [vendor.vendorid, city, address]);
            if (locResult.rowCount === 0) {
                await client.query('ROLLBACK');
                return res.status(500).json({ error: 'Failed to add vendor location' });
            }
        }

        const insertVendorContact = 'INSERT INTO vendor_contact (vendorid, phonenumber) VALUES ($1, $2)';

        for (const phone of phoneNumber) {
            const contactResult = await client.query(insertVendorContact, [vendor.vendorid, phone]);
            if (contactResult.rowCount === 0) {
                await client.query('ROLLBACK');
                return res.status(500).json({ error: 'Failed to add vendor contact' });
            }
        }

        if (Array.isArray(vendor_social)) {
            const insertVendorSocial = 'INSERT INTO vendor_social (vendorid, name, url) VALUES ($1, $2, $3)';

            for (const social of vendor_social) {
                const { name, url } = social;

                const socialResult = await client.query(insertVendorSocial, [vendor.vendorid, name, url]);

                if (socialResult.rowCount === 0) {
                    await client.query('ROLLBACK');
                    return res.status(500).json({ error: 'Failed to add vendor social link' });
                }
            }
        }

        const insertBalanceQuery = 'INSERT INTO vendor_accounts (vendorid, balance) VALUES ($1, $2)';

        const balanceResult = await client.query(insertBalanceQuery, [vendor.vendorid, 0]);

        if (balanceResult.rowCount === 0) {
            await client.query('ROLLBACK');
            return res.status(500).json({ error: 'Failed to create vendor account balance' });
        }

        await client.query('COMMIT');
        res.status(201).json({ message: 'Vendor created successfully', vendor: { vendorid: vendor.vendorid, username: vendor.username } });
    } catch (error) {
        console.error('Error during vendor signup:', error);
        if (error.code === '23505' && error.detail.includes('username')) {
            return res.status(400).json({ message: 'Username is already taken' });
        } else if (error.code === '23505' && error.detail.includes('email')) {
            return res.status(400).json({ message: 'Email is already registered' });
        } else if (error.code === '23505' && error.detail.includes('phonenumber')) {
            return res.status(400).json({ message: 'One of the phone numbers is already registered or duplicated' });
        } else if (error.code === '23505' && error.detail.includes('vendorid, address, city')) {
            return res.status(400).json({ message: 'One of the vendor locations is already registered or duplicated' });
        } else if (error.code === '23505' && error.detail.includes('vendorid, url')) {
            return res.status(400).json({ message: 'One of the social media is already registered or duplicated' });
        }
        res.status(500).json({ error: 'Internal server error' });
    } finally {
        client.release();
    }
};

module.exports = vendorSignup;