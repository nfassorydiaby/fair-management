package models

import "time"

type Kermesse struct {
	ID           uint       `gorm:"primaryKey"`
	Name         string     `gorm:"size:100"`
	Organizers   []Organizer
	Participants []User     `gorm:"many2many:kermesse_participants;constraint:OnUpdate:CASCADE,OnDelete:SET NULL;"`
	Stands       []Stand
	CreatedAt    time.Time
	UpdatedAt    time.Time
}
