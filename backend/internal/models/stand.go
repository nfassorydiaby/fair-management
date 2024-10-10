package models

import "time"

type StandType string

const (
	FoodStand    StandType = "food"
	DrinkStand   StandType = "drink"
	ActivityStand StandType = "activity"
)

type Stand struct {
	ID          uint      `gorm:"primaryKey"`
	Name        string    `gorm:"size:100"`
	Type        StandType `gorm:"size:50"`
	Stock       int
	KermesseID  uint
	CreatedAt   time.Time
	UpdatedAt   time.Time
}
