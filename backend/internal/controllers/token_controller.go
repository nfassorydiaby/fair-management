package controllers

import (
	"backend/internal/database"
	"backend/internal/models"
	"encoding/json"
	"net/http"
)

// BuyTokensHandler permet à un parent d'acheter des jetons
func BuyTokensHandler(db *database.GormDB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var payment models.Payment
		json.NewDecoder(r.Body).Decode(&payment)

		// Enregistrer l'achat de jetons
		err := db.DB.Create(&payment).Error
		if err != nil {
			http.Error(w, "Failed to process payment", http.StatusInternalServerError)
			return
		}

		// Ajouter les jetons au parent
		var parent models.Parent
		err = db.DB.First(&parent, "id = ?", payment.ParentID).Error
		if err != nil {
			http.Error(w, "Parent not found", http.StatusNotFound)
			return
		}
		parent.Tokens += payment.Tokens
		err = db.DB.Model(&parent).Update("tokens", parent.Tokens).Error
		if err != nil {
			http.Error(w, "Failed to update tokens", http.StatusInternalServerError)
			return
		}

		json.NewEncoder(w).Encode(parent)
	}
}

// GiveTokensHandler permet à un parent de distribuer des jetons à ses enfants
func GiveTokensHandler(db *database.GormDB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var input struct {
			ParentID   uint `json:"parent_id"`
			StudentID  uint `json:"student_id"`
			TokenCount int  `json:"token_count"`
		}
		json.NewDecoder(r.Body).Decode(&input)

		// Vérifie que le parent a suffisamment de jetons
		var parent models.Parent
		err := db.DB.First(&parent, "id = ?", input.ParentID).Error
		if err != nil || parent.Tokens < input.TokenCount {
			http.Error(w, "Insufficient tokens", http.StatusBadRequest)
			return
		}

		// Transfert des jetons à l'enfant
		var student models.Student
		err = db.DB.First(&student, "id = ?", input.StudentID).Error
		if err != nil {
			http.Error(w, "Student not found", http.StatusNotFound)
			return
		}

		parent.Tokens -= input.TokenCount
		student.Tokens += input.TokenCount

		err = db.DB.Model(&parent).Update("tokens", parent.Tokens).Error
		if err != nil {
			http.Error(w, "Failed to update parent tokens", http.StatusInternalServerError)
			return
		}

		err = db.DB.Model(&student).Update("tokens", student.Tokens).Error
		if err != nil {
			http.Error(w, "Failed to update student tokens", http.StatusInternalServerError)
			return
		}

		json.NewEncoder(w).Encode(student)
	}
}
