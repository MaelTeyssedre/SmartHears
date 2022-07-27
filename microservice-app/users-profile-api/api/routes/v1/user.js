const express = require('express');
const router = express.Router();

const service = require('../../services/v1/user');

router.get('/:id', service.getById);

router.put('/add', service.add);

router.patch('/update', service.update);

router.delete('/delete', service.delete);

module.exports = router;
