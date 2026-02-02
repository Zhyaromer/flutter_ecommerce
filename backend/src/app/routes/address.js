const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth/auth');
const getAddresses = require('../controllers/address/getAddresses');
const addAddress = require('../controllers/address/addAddress');
const editAddress = require('../controllers/address/editAddress');
const deleteAddress = require('../controllers/address/deleteAddress');

// Get all addresses for the authenticated user
router.get('/getalladdresses', auth(), getAddresses);

// Add a new address
router.post('/addaddresses', auth(), addAddress);

// Edit an existing address
router.post('/editaddress/:addressid', auth(), editAddress);

// Delete an address
router.delete('/deleteaddress/:addressid', auth(), deleteAddress);

module.exports = router;
