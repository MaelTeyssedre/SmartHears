var express = require('express');
var router = express.Router();

const userController = require('./user');

router.get('/', async (req, res) => {
    res.status(200).json({
        status : 200, 
        message: 'hello api from user profile api'
    });
});

router.use('/users', userController);

module.exports = router;
