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

// RegisterStandRoutes enregistre les routes pour la gestion des stands
func RegisterStandRoutes(router *mux.Router, api *swag.API, db *gorm.DB) {
	gormDB := database.NewGormDB(db)

	api.AddEndpoint(
		endpoint.New(
			http.MethodPost, "/add-stand",
			endpoint.Handler(http.HandlerFunc(controllers.AddStandHandler(gormDB))),
			endpoint.Summary("Add a stand"),
			endpoint.Description("Allows organizers to add a new stand"),
			endpoint.Body(struct {
				Name  string `json:"name"`
				Stock int    `json:"stock"`
			}{}, "Stand data", true),
			endpoint.Response(201, "Stand successfully added", nil),
			endpoint.Tags("Stands"),
		),
		endpoint.New(
			http.MethodPatch, "/update-stand",
			endpoint.Handler(http.HandlerFunc(controllers.UpdateStandHandler(gormDB))),
			endpoint.Summary("Update a stand"),
			endpoint.Description("Allows organizers to update the stand information"),
			endpoint.Body(struct {
				StandID uint   `json:"stand_id"`
				Name    string `json:"name"`
				Stock   int    `json:"stock"`
			}{}, "Updated stand data", true),
			endpoint.Response(200, "Stand successfully updated", nil),
			endpoint.Tags("Stands"),
		),
		endpoint.New(
			http.MethodPost, "/consume-tokens",
			endpoint.Handler(http.HandlerFunc(controllers.ConsumeTokensHandler(gormDB))),
			endpoint.Summary("Consume tokens"),
			endpoint.Description("Allows participants to consume tokens on a stand"),
			endpoint.Body(struct {
				UserID  uint `json:"user_id"`
				StandID uint `json:"stand_id"`
				Tokens  int  `json:"tokens"`
			}{}, "Token consumption data", true),
			endpoint.Response(200, "Tokens successfully consumed", nil),
			endpoint.Tags("Stands"),
		),
	)

	api.Walk(func(path string, e *swag.Endpoint) {
		h := e.Handler.(http.HandlerFunc)
		router.Path(path).Methods(e.Method).Handler(h)
	})
}
