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

// RegisterAuthRoutes enregistre les routes protégées avec Swagger
func RegisterAuthRoutes(router *mux.Router, api *swag.API, db *gorm.DB) {
	gormDB := database.NewGormDB(db)

	api.AddEndpoint(
		endpoint.New(
			http.MethodPost, "/registerAdmin",
			endpoint.Handler(http.HandlerFunc(controllers.RegisterUserAdmin(gormDB))),
			endpoint.Summary("Register a new admin"),
			endpoint.Description("Register a new admin with a name, email, and password"),
			endpoint.Body(struct {
				Name     string `json:"name"`     // Nom de l'administrateur
				Email    string `json:"email"`    // Email de l'administrateur
				Password string `json:"password"` // Mot de passe de l'administrateur
			}{}, "Admin registration data", true), // Champs d'inscription d'un administrateur
			endpoint.Response(http.StatusCreated, "Admin successfully registered", endpoint.SchemaResponseOption(&map[string]string{
				"message": "Admin created successfully",
				"id":      "ID of the newly created admin",
			})), // Réponse : succès
			endpoint.Tags("Admin"),
		),
		endpoint.New(
			http.MethodGet, "/users",
			endpoint.Handler(http.HandlerFunc(controllers.GetAllUsers(gormDB))),
			endpoint.Summary("Get all users"),
			endpoint.Description("Retrieve all users"),
			endpoint.Response(http.StatusOK, "Successfully retrieved users", endpoint.SchemaResponseOption(&[]struct {
				ID    uint   `json:"id"`
				Name  string `json:"name"`
				Email string `json:"email"`
				Role  string `json:"role"`
			}{})), // Réponse : liste d'utilisateurs
			endpoint.Tags("Users"),
		),
	)

	// Ajouter les routes à Gorilla Mux
	api.Walk(func(path string, e *swag.Endpoint) {
		h := e.Handler.(http.HandlerFunc)
		router.Path(path).Methods(e.Method).Handler(h)
	})
}

