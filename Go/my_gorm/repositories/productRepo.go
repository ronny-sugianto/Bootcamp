package repositories

import (
	"github.com/jinzhu/gorm"
	"mylabstudio.info/mygorm/models"
)

type productRepo struct {
	Conn *gorm.DB
}

func NewProductRepo(Conn *gorm.DB) *productRepo {
	return &productRepo{
		Conn: Conn,
	}
}

func (p *productRepo) GetAllProduct() (*[]models.Product, error) {
	productList := new([]models.Product)

	result := p.Conn.Find(&productList)

	return productList, result.Error
}

func (p *productRepo) GetProductById(id string) (*models.Product, error) {
	product := new(models.Product)
	result := p.Conn.First(&product, "code = ?", id)
	return product, result.Error
}

