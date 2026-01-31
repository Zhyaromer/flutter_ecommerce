const db = require('../../config/database');

const changeEmail = async (req, res) => {
    const { newEmail } = req.body;
    const cleanEmail = newEmail?.trim().toLowerCase();

    if (!cleanEmail || cleanEmail.length < 5 || cleanEmail.length > 50) {
        return res.status(400).json({ message: 'Email must be between 5 and 50 characters' });
    }

    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!emailRegex.test(cleanEmail)) {
        return res.status(400).json({ message: 'Email contains invalid characters or format.' });
    }

    try {
        const userResult = await db.query(
            'SELECT last_email_change FROM users WHERE userid = $1',
            [req.user.userid]
        );

        if (userResult.rows.length === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        const lastChange = userResult.rows[0].last_email_change;

        const now = new Date();
        const cooldown = 14 * 24 * 60 * 60 * 1000;

        if (lastChange && now - new Date(lastChange) < cooldown) {
            return res.status(400).json({ message: 'You can only change your email once every 14 days' });
        }

        const result = await db.query(
            'UPDATE users SET email = $1, last_email_change = NOW() WHERE userid = $2 RETURNING userid, email',
            [cleanEmail, req.user.userid]
        );

        const user = result.rows[0];

        return res.status(200).json({
            message: 'Email updated!',
            email: user.email
        });

    } catch (error) {
        if (error.code === '23505') {
            return res.status(400).json({ message: 'Email is already taken' });
        }
        console.error('Critical Error in changeEmail:', error);
        return res.status(500).json({ message: 'Server error' });
    }
}

module.exports = changeEmail;