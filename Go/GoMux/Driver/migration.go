package Driver

import (
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"gomux/Models"


)

func InitTable(db *gorm.DB) {
	db.Debug().AutoMigrate(&Models.Users{})


}
