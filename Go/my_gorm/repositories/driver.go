package repositories

import (
	"github.com/jinzhu/gorm"
)

type DB struct {
	Sql *gorm.DB
}

var dbConn = &DB{}

type DbDriver struct {
	dbDialect string
	dbSource  string
}

func DriverInfo(dbDialect string, dbSource string) *DbDriver {
	return &DbDriver{
		dbDialect: dbDialect,
		dbSource:  dbSource,
	}
}

func (driver *DbDriver) Connect() (*DB, error) {
	db, err := gorm.Open(driver.dbDialect, driver.dbSource)
	dbConn.Sql = db
	return dbConn, err
}

func (driver *DbDriver) Close(db *DB) {
	db.Sql.Close()
}
