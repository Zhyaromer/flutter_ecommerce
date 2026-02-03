const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth/auth');

const getAllInterests = require('../controllers/interests/getallinterests');
const getUserInterests = require('../controllers/interests/getuserinterests');
const addInterests = require('../controllers/interests/addinterests');
const deleteInterests = require('../controllers/interests/deleteinterests');
const saveInterests = require('../controllers/interests/saveinterests');

router.get('/getAllInterests', getAllInterests);

router.get('/getUserInterests', auth(), getUserInterests);

router.post('/addInterests', auth(), addInterests);

router.delete('/deleteInterests', auth(), deleteInterests);

router.post('/saveInterests', auth(), saveInterests);

module.exports = router;