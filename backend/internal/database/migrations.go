package database

import (
	"backend/internal/models"
	"gorm.io/gorm"
)

// MigrateAll migre toutes les tables nécessaires dans le bon ordre
func MigrateAll(db *gorm.DB) error {
	// Migrer les tables dans le bon ordre pour éviter les problèmes de dépendance
	return db.AutoMigrate(
		&models.User{},
		&models.Kermesse{},    
		&models.Stand{},
		&models.Student{},
		&models.Parent{},
		&models.StandManager{},
		&models.Kermesse{},    
		&models.Organizer{},
		&models.Transaction{},
		&models.Tombola{},
		&models.Payment{},
	)
}
