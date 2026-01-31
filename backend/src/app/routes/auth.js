const express = require('express');
const router = express.Router();
const signup = require('../controllers/auth/signup');
const login = require('../controllers/auth/Login');
const auth = require('../middleware/auth/auth');
const logout = require('../controllers/auth/logout');
const changeName = require('../controllers/auth/changename');
const refresh = require('../controllers/auth/refresh');

// Refresh token route
router.post('/refresh', refresh);

// Change name route
router.post('/changename', auth(), changeName);

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