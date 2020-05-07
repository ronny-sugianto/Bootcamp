const logEvent = require('../events/myEmitter');
const Product = require('../models/product.model');
const Category = require('../models/category.model');
const sequelize = require('../../dbConn');

class ProductService {
    async getAllProduct() {
        let result;
        try {
            // result = await Product.findAll();
            result = await Product.findAll({include: Category});
        } catch (e) {
            logEvent.emit('APP-ERROR', {
                logTitle: 'GET-PRODUCT-SERVICE-FAILED',
                logMessage: e
            });
            throw new Error(e);
        }
        return result;
    }

    async getAllProductPaging(offset, limit) {
        let result;
        try {
            // result = await Product.findAll();
            result = await Product.findAndCountAll({offset: Number(offset), limit: Number(limit)});
        } catch (e) {
            logEvent.emit('APP-ERROR', {
                logTitle: 'GET-PRODUCT-SERVICE-FAILED',
                logMessage: e
            });
            throw new Error(e);
        }
        return result;
    }

    async getProductById(id) {
        let result;
        try {
            result = await await sequelize.query('SELECT * FROM product where id=:id', {
                model: Product,
                mapToModel: true,
                replacements: {id: id},
            });
        } catch (e) {
            logEvent.emit('APP-ERROR', {
                logTitle: 'GET-PRODUCT-SERVICE-FAILED',
                logMessage: e
            });
        }
        return result;
    }

    async createProduct(product) {
        const promise = new Promise((resolve, reject) => {
            // product.id = uuidv1();
            // products.push(product);
            // resolve(product);
            connection.query('insert into product(product_name,product_description) values(?,?)',
                [product.productName, product.productDescription],
                (err, rows, fields) => {
                    if (err) {
                        reject(err);
                    } else {
                        resolve(product);
                    }
                });
        });
        let result;
        try {
            result = await promise;
        } catch (e) {
            logEvent.emit('APP-ERROR', {
                logTitle: 'CREATE-PRODUCT-SERVICE-FAILED',
                logMessage: e
            });
        }
        return result;
    }

    async updateProduct(product) {
        const promise = new Promise((resolve, reject) => {
            const idx = _.findIndex(products, function (o) {
                return o.id == product.id;
            });
            products.splice(idx, 1, product);
            resolve(product);
        });
        let result;
        try {
            result = await promise;
        } catch (e) {
            logEvent.emit('APP-ERROR', {
                logTitle: 'UPDATE-PRODUCT-SERVICE-FAILED',
                logMessage: e
            });
        }
        return result;
    }

    async deleteProduct(productId) {
        const promise = new Promise((resolve, reject) => {
            const idx = _.findIndex(products, function (o) {
                return o.id == productId;
            });
            products.splice(idx, 1);
            resolve(productId);
        });
        let result;
        try {
            result = await promise;
        } catch (e) {
            logEvent.emit('APP-ERROR', {
                logTitle: 'DELETE-PRODUCT-SERVICE-FAILED',
                logMessage: e
            });
        }
        return result;
    }
}

module.exports = ProductService;