package models

import "time"

type Parent struct {
	ID         uint      `gorm:"primaryKey"`
	UserID     uint      `gorm:"unique"`
	User       User      `gorm:"foreignKey:UserID"`
	Children   []Student `gorm:"many2many:parent_students;"`
	Tokens     int       `gorm:"default:0"`
	CreatedAt  time.Time
	UpdatedAt  time.Time
}
