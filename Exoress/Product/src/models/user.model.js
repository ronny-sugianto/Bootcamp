const Sequelize = require("sequelize");
const connection = require('../../dbConn');

const SysUser = connection.define('sysUser', {
    id: {
        type: Sequelize.UUID,
        defaultValue: Sequelize.UUIDV1,
        allowNull: false,
        primaryKey: true,
    },
    userName: {
        type: Sequelize.STRING,
        allowNull: false,
    },
    userPassword: {
        type: Sequelize.STRING,
        allowNull: false,
        min: 6
    },
    fullName: {
        type: Sequelize.STRING,
        allowNull: false,
    },
    email: {
        type: Sequelize.STRING,
        validate: {
            isEmail: true
        }
    },
}, {
    freezeTableName: true,
    tableName: 'sysUser'
});

module.exports = SysUser;