const Sequelize = require("sequelize");
const connection = require('../../dbConn');

const Product = connection.define('product', {
    id: {
        type: Sequelize.UUID,
        defaultValue: Sequelize.UUIDV1,
        allowNull: false,
        primaryKey: true,
    },
    productCode: {
        type: Sequelize.STRING
    },
    productName: {
        type: Sequelize.STRING
    }
}, {
    freezeTableName: true,
    tableName: 'product',
    paranoid: true,
});

module.exports = Product;