package models

import "time"

type Organizer struct {
	ID         uint   `gorm:"primaryKey"`
	UserID     uint   `gorm:"unique"`
	User       User   `gorm:"foreignKey:UserID;constraint:OnUpdate:CASCADE,OnDelete:SET NULL;"`
	KermesseID uint   `gorm:"foreignKey:KermesseID;constraint:OnUpdate:CASCADE,OnDelete:SET NULL;"`
	Tickets    int    `gorm:"default:0"`
	Revenue    float64
	CreatedAt  time.Time
	UpdatedAt  time.Time
}
