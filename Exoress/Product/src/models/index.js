const Category = require('./category.model');
const Product = require('./product.model');
const Order = require('./order.model');

const dbAssociation = function dbAssociation() {
    Category.hasMany(Product);
    Product.belongsTo(Category);

    Order.belongsToMany(Product, {through: 'orderItem'});
    Product.belongsToMany(Order, {through: 'orderItem'});
};

module.exports = dbAssociation;
