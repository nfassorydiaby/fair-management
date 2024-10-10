package models

import "time"

type Tombola struct {
	ID        uint   `gorm:"primaryKey"`
	Entries   []Student `gorm:"many2many:tombola_entries;"`
	Winners   []Student `gorm:"many2many:tombola_winners;"`
	Drawn     bool
	CreatedAt time.Time
	UpdatedAt time.Time
}
