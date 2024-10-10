package routes

import (
	"backend/internal/controllers"
	"backend/internal/database"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/zc2638/swag/endpoint"
	"github.com/zc2638/swag"
	"gorm.io/gorm"
)

// RegisterPublicRoutes enregistre les routes publiques avec Swagger
func RegisterPublicRoutes(router *mux.Router, api *swag.API, db *gorm.DB) {
	// Créer un wrapper *database.GormDB à partir de *gorm.DB
	gormDB := database.NewGormDB(db)

	api.AddEndpoint(
		endpoint.New(
			http.MethodPost, "/register",
			endpoint.Handler(http.HandlerFunc(controllers.RegisterUser(gormDB))),
			endpoint.Summary("Register a new user"),
			endpoint.Description("Register a new user with a name, email, password, and role"),
			endpoint.Body(struct {
				Name     string `json:"name"`     // Nom de l'utilisateur
				Email    string `json:"email"`    // Email de l'utilisateur
				Password string `json:"password"` // Mot de passe de l'utilisateur
				Role     string `json:"role"`     // Rôle de l'utilisateur
			}{}, "User registration data", true), // Définir les champs d'inscription
			endpoint.Response(http.StatusCreated, "User successfully registered", endpoint.SchemaResponseOption(&map[string]string{
				"message": "User created successfully",
				"id":      "ID of the newly created user",
			})), // Réponse : succès
			endpoint.Tags("Auth"),
		),
		endpoint.New(
			http.MethodPost, "/login",
			endpoint.Handler(http.HandlerFunc(controllers.LoginUser(gormDB))),
			endpoint.Summary("Login a user"),
			endpoint.Description("Login a user and get a token"),
			endpoint.Body(struct {
				Email    string `json:"email"`    // Email de l'utilisateur
				Password string `json:"password"` // Mot de passe de l'utilisateur
			}{}, "User credentials", true), // Définir les champs de connexion
			endpoint.Response(http.StatusOK, "Successfully logged in", endpoint.SchemaResponseOption(&map[string]string{
				"token": "JWT token for authentication",
			})), // Réponse : token JWT
			endpoint.Tags("Auth"),
		),
	)

	// Ajouter les routes à Gorilla Mux
	api.Walk(func(path string, e *swag.Endpoint) {
		h := e.Handler.(http.HandlerFunc)
		router.Path(path).Methods(e.Method).Handler(h)
	})
}
