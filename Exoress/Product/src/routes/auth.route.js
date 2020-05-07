const express = require('express');
const router = express.Router();
const AuthService = require('../services/auth.service');
const {userAuthentication} = require("../controllers/user.controller");

const authService = new AuthService();

router.post('/', (req, res, next) => userAuthentication(req, res, authService));

module.exports = router;