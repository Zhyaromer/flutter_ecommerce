const express = require('express');
const router = express.Router();
const vendorSignup = require('../controllers/vendor/vendorsignup');

// Vendor Signup route
router.post('/vendorsignup', vendorSignup);

module.exports = router;