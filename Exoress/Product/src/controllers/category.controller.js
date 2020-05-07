const getCategoryList = async (req, res, service) => {
    try {
        let categories;
        if (req.query.id) {
            const id = req.query.id;
            categories = await service.getCategoryById(id)
        } else if (req.query.pageNo && req.query.rowPage) {
            categories = await service.getAllCategoryPaging(req.query.pageNo, req.query.rowPage);
        } else {
            categories = await service.getAllCategory();
        }
        res.send(categories);
    } catch (e) {
        res.sendStatus(500);
    }
};

module.exports = {
    getCategoryList
};