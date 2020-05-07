const express = require('express');
const router = express.Router();

router.get('/', (req, res, next) => {
    res.sendFile(path.join(__dirname, '../', 'views', 'product.html'));
});
router.post('/', (req, res, next) => {
    console.log(req.body);
    res.redirect('/admin/products');
});

module.exports = router;