const express = require('express');
const router = express.Router();

const productRoutes = require('./product.route');
const categoryRoutes = require('./category.route');
const userRoutes = require('./user.route');
const authRoutes = require('./auth.route');
const noRoute = require('./no.route');
const logRoute = require('./log.route');

router.use(logRoute);
router.use('/auth', authRoutes);
router.use('/product', productRoutes);
router.use('/category', categoryRoutes);
router.use('/user', userRoutes);
router.use(noRoute);

module.exports = router;