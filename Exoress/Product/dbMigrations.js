const connection = require('./dbConn');
const Product = require('./src/models/product.model');
const Category = require('./src/models/category.model');
const dbAssociation = require('./src/models/index');
require('./src/models/orderItem.model');
const SysUser = require('./src/models/user.model');

const bcrypt = require('bcryptjs');

async function migration() {
    dbAssociation();
    await connection.sync({force: true});
    let category01 = await Category.create({categoryName: 'Bumbu Dapur'});
    let category02 = await Category.create({categoryName: 'Furnitur'});

    let prod01 = await Product.create(
        {productCode: 'ABC', productName: 'Minyak Goreng'});
    prod01.setCategory(category01);

    let prod02 = await Product.create(
        {productCode: 'DEF', productName: 'Garam'});
    prod02.setCategory(category01);

    let prod03 = await Product.create(
        {productCode: 'XYZ', productName: 'Meja Makan'});
    prod03.setCategory(category02);

    let prod04 = await Product.create(
        {productCode: 'UCV', productName: 'Meja Belajar'});
    prod04.setCategory(category02);

    let prod05 = await Product.create(
        {productCode: 'NYR', productName: 'Kasur'});
    prod05.setCategory(category02);

    let prod06 = await Product.create(
        {productCode: 'OQW', productName: 'Kecap Manis'});
    prod06.setCategory(category01);

    var passwordHash = bcrypt.hashSync('P@ssw0rd', 8);
    await SysUser.create(
        {userName: 'edo', userPassword: passwordHash, fullName: 'Edo', email: 'edo@example.com'}
    )
}

migration();