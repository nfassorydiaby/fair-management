package models

import "time"

type Payment struct {
	ID        uint    `gorm:"primaryKey"`
	ParentID  uint    `gorm:"foreignKey:UserID"`
	Amount    float64
	Tokens    int
	CreatedAt time.Time
	UpdatedAt time.Time
}
