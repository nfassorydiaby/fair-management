package controllers

import (
    "backend/internal/database"
    "backend/internal/models"
    "encoding/json"
    "net/http"
)

// GetChildrenHandler permet aux parents de voir leurs enfants et leurs jetons
func GetChildrenHandler(db *database.GormDB) http.HandlerFunc {
    return func(w http.ResponseWriter, r *http.Request) {
        var input struct {
            ParentID uint `json:"parent_id"`
        }
        err := json.NewDecoder(r.Body).Decode(&input)
		if err != nil {
			http.Error(w, "Invalid request payload", http.StatusBadRequest)
			return
		}

        var children []models.Student
        if err := db.DB.Where("parent_id = ?", input.ParentID).Find(&children).Error; err != nil {
            http.Error(w, "Failed to retrieve children", http.StatusInternalServerError)
            return
        }

        json.NewEncoder(w).Encode(children)
    }
}
