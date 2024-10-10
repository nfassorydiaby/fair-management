package routes

import (
	"github.com/gorilla/mux"
	"github.com/zc2638/swag"
)

// RegisterSwaggerRoutes ajoute les routes Swagger
func RegisterSwaggerRoutes(router *mux.Router, api *swag.API) {
	// Route pour la documentation Swagger JSON
	router.Path("/swagger/json").Methods("GET").Handler(api.Handler())

	// Interface utilisateur Swagger UI
	router.PathPrefix("/swagger/ui").Handler(swag.UIHandler("/swagger/ui", "/swagger/json", true))
}
