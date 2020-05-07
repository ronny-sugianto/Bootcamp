const getProductList = async (req, res, service) => {
    try {
        let products;
        if (req.query.id) {
            const id = req.query.id;
            products = await service.getProductById(id)
        } else if (req.query.pageNo && req.query.rowPage) {
            products = await service.getAllProductPaging(req.query.pageNo, req.query.rowPage);
        } else {
            products = await service.getAllProduct();
        }
        res.send(products);
    } catch (e) {
        res.sendStatus(500);
    }

};

const addNewProduct = async (req, res, service) => {
    const product = req.body;
    const newProduct = await service.createProduct(product);
    res.send(newProduct);
};

const updateProduct = async (req, res, service) => {
    const product = req.body;
    const updatedProduct = await service.updateProduct(product);
    res.send(updatedProduct);
};

const deleteProduct = async (req, res, service) => {
    const productId = req.params.id;
    const deleteProduct = await service.deleteProduct(productId);
    res.send({id: productId});
};

module.exports = {
    getProductList, addNewProduct, updateProduct, deleteProduct
};