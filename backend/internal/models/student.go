package models

import "time"

type Student struct {
	ID        uint   `gorm:"primaryKey"`
	UserID    uint   `gorm:"unique"`
	User      User   `gorm:"foreignKey:UserID"`
	Tokens    int    `gorm:"default:0"`
	Tickets   int    `gorm:"default:0"`
	CreatedAt time.Time
	UpdatedAt time.Time
}
