const express = require('express');
const router = express.Router();
const signup = require('../controllers/auth/signup');
const login = require('../controllers/auth/Login');
const auth = require('../middleware/auth/auth');
const logout = require('../controllers/auth/logout');

// Logout route
router.post('/logout', auth(), logout);

// Signup route
router.post('/signup', signup);

// Login route
router.post('/login', login);

router.get('/test', auth(), (req, res) => {
    res.json({ message: 'Auth route is working' });
});

module.exports = router;