package main

import (
	"backend/internal/database"
	"backend/internal/routes"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/joho/godotenv"
	"github.com/zc2638/swag"
	"github.com/zc2638/swag/option"
)

func main() {
	// Charger les variables d'environnement
	err := godotenv.Load()
	if err != nil {
		log.Fatalf("Error loading .env file: %v", err)
	}

	// Connexion à la base de données
	db, err := database.ConnectDB()
	if err != nil {
		log.Fatalf("Error connecting to database: %v", err)
	}

	// Lancer la migration des tables
	err = database.MigrateAll(db)
	if err != nil {
		log.Fatalf("Failed to migrate database: %v", err)
	}

	
	// Initialisation de l'API Swagger
	api := swag.New(
		option.Title("API Documentation"),
		option.Version("1.0"),
		option.Description("API documentation for our project"),
	)

	// Créer le routeur
	router := mux.NewRouter()

	routes.RegisterStandRoutes(router, api, db)            

	// Enregistrement des routes
	routes.RegisterPublicRoutes(router, api, db)      
	routes.RegisterAuthRoutes(router, api, db)   
	routes.RegisterSwaggerRoutes(router, api)
	routes.RegisterTokenRoutes(router, api, db)       
	routes.RegisterTombolaRoutes(router, api, db)     
	routes.RegisterParentRoutes(router, api, db)      

	// Démarrage du serveur HTTP
	log.Fatal(http.ListenAndServe(":8080", router))
}
