package controllers

import (
	"backend/internal/database"
	"backend/internal/models"
	"encoding/json"
	"math/rand"
	"net/http"
)

// EnterTombolaHandler permet à un élève de participer à la tombola
func EnterTombolaHandler(db *database.GormDB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var input struct {
			StudentID uint `json:"student_id"`
			Tickets   int  `json:"tickets"`
		}
		json.NewDecoder(r.Body).Decode(&input)

		var student models.Student
		err := db.DB.First(&student, "id = ?", input.StudentID).Error
		if err != nil {
			http.Error(w, "Student not found", http.StatusNotFound)
			return
		}

		// Ajouter les billets à la tombola
		student.Tickets += input.Tickets
		err = db.DB.Model(&student).Update("tickets", student.Tickets).Error
		if err != nil {
			http.Error(w, "Failed to update tickets", http.StatusInternalServerError)
			return
		}

		json.NewEncoder(w).Encode(student)
	}
}

// DrawTombolaHandler effectue le tirage au sort de la tombola
func DrawTombolaHandler(db *database.GormDB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var students []models.Student
		db.DB.Find(&students)

		if len(students) == 0 {
			http.Error(w, "No students entered", http.StatusNotFound)
			return
		}

		// Tirage au sort
		winner := students[rand.Intn(len(students))]

		json.NewEncoder(w).Encode(map[string]interface{}{
			"winner": winner.User.Name,  // Accéder au nom de l'utilisateur lié
			"id":     winner.ID,
		})
	}
}
