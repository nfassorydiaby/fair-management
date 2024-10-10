package controllers

import (
	"backend/internal/database"
	"backend/internal/models"
	"encoding/json"
	"net/http"
)

// AddStandHandler permet à un organisateur d'ajouter un nouveau stand
func AddStandHandler(db *database.GormDB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var stand models.Stand
		err := json.NewDecoder(r.Body).Decode(&stand)
		if err != nil {
			http.Error(w, "Invalid input", http.StatusBadRequest)
			return
		}

		// Enregistrer le nouveau stand
		if err := db.DB.Create(&stand).Error; err != nil {
			http.Error(w, "Failed to create stand", http.StatusInternalServerError)
			return
		}

		json.NewEncoder(w).Encode(stand)
	}
}

// UpdateStandHandler permet à un organisateur de mettre à jour un stand
func UpdateStandHandler(db *database.GormDB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var input struct {
			StandID uint   `json:"stand_id"`
			Name    string `json:"name"`
			Stock   int    `json:"stock"`
		}
		if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
			http.Error(w, "Invalid input", http.StatusBadRequest)
			return
		}

		var stand models.Stand
		if err := db.DB.First(&stand, input.StandID).Error; err != nil {
			http.Error(w, "Stand not found", http.StatusNotFound)
			return
		}

		stand.Name = input.Name
		stand.Stock = input.Stock

		if err := db.DB.Save(&stand).Error; err != nil {
			http.Error(w, "Failed to update stand", http.StatusInternalServerError)
			return
		}

		json.NewEncoder(w).Encode(stand)
	}
}

// ConsumeTokensHandler gère la consommation de jetons sur un stand
func ConsumeTokensHandler(db *database.GormDB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var input struct {
			UserID  uint `json:"user_id"`
			StandID uint `json:"stand_id"`
			Tokens  int  `json:"tokens"`
		}
		json.NewDecoder(r.Body).Decode(&input)

		// Vérification du nombre de jetons
		var user models.User
		err := db.DB.First(&user, "id = ?", input.UserID).Error
		if err != nil || user.Tokens < input.Tokens {
			http.Error(w, "Insufficient tokens", http.StatusBadRequest)
			return
		}

		// Mise à jour des jetons de l'utilisateur
		user.Tokens -= input.Tokens
		err = db.DB.Model(&user).Update("tokens", user.Tokens).Error
		if err != nil {
			http.Error(w, "Failed to update tokens", http.StatusInternalServerError)
			return
		}

		// Mise à jour des stocks du stand
		var stand models.Stand
		err = db.DB.First(&stand, "id = ?", input.StandID).Error
		if err != nil {
			http.Error(w, "Stand not found", http.StatusNotFound)
			return
		}

		stand.Stock -= input.Tokens // Simuler une consommation
		err = db.DB.Model(&stand).Update("stock", stand.Stock).Error
		if err != nil {
			http.Error(w, "Failed to update stand stock", http.StatusInternalServerError)
			return
		}

		json.NewEncoder(w).Encode(stand)
	}
}
