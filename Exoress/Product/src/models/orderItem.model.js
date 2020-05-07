const Sequelize = require("sequelize");
const connection = require('../../dbConn');

const OrderItem = connection.define('orderItem', {
    orderId: {
        type: Sequelize.UUID
    },
    productId: {
        type: Sequelize.UUID
    },
    qty: {
        type: Sequelize.INTEGER
    }
}, {
    freezeTableName: true,
    tableName: 'orderItem'
});

module.exports = OrderItem;