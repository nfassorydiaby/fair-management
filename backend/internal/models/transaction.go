package models

import "time"

type Transaction struct {
	ID          uint   `gorm:"primaryKey"`
	FromUserID  uint   `gorm:"foreignKey:UserID"`
	ToStandID   uint   `gorm:"foreignKey:StandID"`
	TokensUsed  int
	ActivityType string `gorm:"size:50"`
	CreatedAt   time.Time
	UpdatedAt   time.Time
}
