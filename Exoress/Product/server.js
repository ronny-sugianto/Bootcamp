const http = require("http");
const express = require('express');
const logEvent = require('./src/events/myEmitter');
const loggingListener = require('./src/events/logging.listener');
const appMiddleware = require('./src/middlewares/app-middlewares');
const appRoutes = require('./src/routes/index');

loggingListener();
const app = express();
app.use(appMiddleware);
app.use(appRoutes);
const server = http.createServer(app);
server.on('error', function (e) {
    logEvent.emit('APP-ERROR', {
        logTitle: 'APP-FAILED',
        logMessage: e
    });
});
module.exports = server;