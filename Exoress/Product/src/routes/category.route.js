const express = require('express');
const router = express.Router();
const CategoryService = require('../services/category.service');
const {getCategoryList} = require("../controllers/category.controller");
const tokenValidation = require('../middlewares/token-validation');

const categoryService = new CategoryService();

router.use(tokenValidation);
router.get('/', (req, res, next) => getCategoryList(req, res, categoryService));

module.exports = router;