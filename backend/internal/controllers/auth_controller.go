package controllers

import (
	"backend/internal/database"
	"backend/internal/models"
	"encoding/json"
	"net/http"

	"golang.org/x/crypto/bcrypt"
)

// RegisterUser gère l'inscription d'un utilisateur
func RegisterUser(db *database.GormDB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var input struct {
			Name     string `json:"name"`
			Email    string `json:"email"`
			Password string `json:"password"`
			Role     string `json:"role"`  
		}
		err := json.NewDecoder(r.Body).Decode(&input)
		if err != nil {
			http.Error(w, "Invalid request payload", http.StatusBadRequest)
			return
		}

		// Hash du mot de passe
		hashedPassword, err := bcrypt.GenerateFromPassword([]byte(input.Password), bcrypt.DefaultCost)
		if err != nil {
			http.Error(w, "Error hashing password", http.StatusInternalServerError)
			return
		}

		// Créer un nouvel utilisateur
		user := models.User{
			Name:         input.Name,
			Email:        input.Email,
			PasswordHash: string(hashedPassword),
			Role:         models.Role(input.Role),  
		}

		// Enregistrer l'utilisateur dans la base de données
		err = db.DB.Create(&user).Error
		if err != nil {
			http.Error(w, "Error creating user", http.StatusInternalServerError)
			return
		}

		json.NewEncoder(w).Encode(user)
	}
}

// LoginUser gère la connexion d'un utilisateur
func LoginUser(db *database.GormDB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var input struct {
			Email    string `json:"email"`
			Password string `json:"password"`
		}
		err := json.NewDecoder(r.Body).Decode(&input)
		if err != nil {
			http.Error(w, "Invalid request payload", http.StatusBadRequest)
			return
		}

		var user models.User
		err = db.DB.Where("email = ?", input.Email).First(&user).Error
		if err != nil {
			http.Error(w, "Invalid email or password", http.StatusUnauthorized)
			return
		}

		// Vérification du mot de passe
		err = bcrypt.CompareHashAndPassword([]byte(user.PasswordHash), []byte(input.Password))
		if err != nil {
			http.Error(w, "Invalid email or password", http.StatusUnauthorized)
			return
		}

		// Générer et renvoyer un token (à implémenter selon votre logique JWT)
		token := "your_jwt_token"
		json.NewEncoder(w).Encode(map[string]string{"token": token})
	}
}

// RegisterUserAdmin gère l'inscription d'un administrateur
func RegisterUserAdmin(db *database.GormDB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var input struct {
			Name     string `json:"name"`
			Email    string `json:"email"`
			Password string `json:"password"`
		}
		err := json.NewDecoder(r.Body).Decode(&input)
		if err != nil {
			http.Error(w, "Invalid request payload", http.StatusBadRequest)
			return
		}

		// Hash du mot de passe
		hashedPassword, err := bcrypt.GenerateFromPassword([]byte(input.Password), bcrypt.DefaultCost)
		if err != nil {
			http.Error(w, "Error hashing password", http.StatusInternalServerError)
			return
		}

		// Créer un nouvel utilisateur administrateur
		user := models.User{
			Name:         input.Name,
			Email:        input.Email,
			PasswordHash: string(hashedPassword),
			Role:         models.RoleAdmin,  // Spécifiez le rôle administrateur
		}

		// Enregistrer l'utilisateur administrateur
		err = db.DB.Create(&user).Error
		if err != nil {
			http.Error(w, "Error creating admin user", http.StatusInternalServerError)
			return
		}

		json.NewEncoder(w).Encode(user)
	}
}

// GetAllUsers récupère tous les utilisateurs
func GetAllUsers(db *database.GormDB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var users []models.User
		err := db.DB.Find(&users).Error
		if err != nil {
			http.Error(w, "Error retrieving users", http.StatusInternalServerError)
			return
		}

		json.NewEncoder(w).Encode(users)
	}
}
