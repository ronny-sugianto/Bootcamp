const logEvent = require('../events/myEmitter');
const Product = require('../models/product.model');
const Category = require('../models/category.model');

class CategoryService {
    async getAllCategory() {
        let result;
        try {
            // result = await Product.findAll();
            result = await Category.findAll({include: Product});
        } catch (e) {
            logEvent.emit('APP-ERROR', {
                logTitle: 'GET-CATEGORY-SERVICE-FAILED',
                logMessage: e
            });
            throw new Error(e);
        }
        return result;
    }

    async getCategoryById(id) {
        let result;
        try {
            // result = await Product.findAll();
            result = await Category.findByPk(id, {include: Product});
        } catch (e) {
            logEvent.emit('APP-ERROR', {
                logTitle: 'GET-CATEGORY-SERVICE-FAILED',
                logMessage: e
            });
            throw new Error(e);
        }
        return result;
    }

    async createCategory(category) {
        let result;
        try {
            result = await Category.create(category);
        } catch (e) {
            logEvent.emit('APP-ERROR', {
                logTitle: 'CREATE-CATEGORY-SERVICE-FAILED',
                logMessage: e
            });
        }
        return result;
    }

    async updateProduct(newCategory) {
        const category = await Category.findByPk(newCategory.id);
        category.categoryName = newCategory.categoryName;
        let result;
        try {
            result = await category.save();
        } catch (e) {
            logEvent.emit('APP-ERROR', {
                logTitle: 'UPDATE-CATEGORY-SERVICE-FAILED',
                logMessage: e
            });
        }
        return result;
    }

    async deleteProduct(categoryId) {
        const category = await Category.findByPk(categoryId);
        let result;
        try {
            result = await category.destroy();
        } catch (e) {
            logEvent.emit('APP-ERROR', {
                logTitle: 'DELETE-CATEGORY-SERVICE-FAILED',
                logMessage: e
            });
        }
        return result;
    }
}

module.exports = CategoryService;