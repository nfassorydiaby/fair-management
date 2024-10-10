package models

import "time"

type StandManager struct {
	ID         uint   `gorm:"primaryKey"`
	UserID     uint   `gorm:"unique"`
	User       User   `gorm:"foreignKey:UserID"`
	StandID    uint   `gorm:"foreignKey:StandID"`
	Tokens     int    `gorm:"default:0"`
	Points     int    `gorm:"default:0"`
	CreatedAt  time.Time
	UpdatedAt  time.Time
}
