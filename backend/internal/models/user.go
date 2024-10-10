package models

import (
	"time"
)

type Role string

const (
	RoleStudent     Role = "student"
	RoleParent      Role = "parent"
	RoleStandManager Role = "stand_manager"
	RoleOrganizer   Role = "organizer"
	RoleAdmin       Role = "admin" // Ajout du rôle Admin
)

type User struct {
	ID           uint      `gorm:"primaryKey"`
	Name         string    `gorm:"size:100"`
	Email        string    `gorm:"unique"`
	PasswordHash string
	Role         Role      `gorm:"size:50"`
	Tokens       int       `gorm:"default:0"` 
	CreatedAt    time.Time
	UpdatedAt    time.Time
}
