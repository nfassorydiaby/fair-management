package routes

import (
	"backend/internal/controllers"
	"backend/internal/database"
	"github.com/gorilla/mux"
	"github.com/zc2638/swag"
	"github.com/zc2638/swag/endpoint"
	"gorm.io/gorm"
	"net/http"
)

// RegisterTombolaRoutes enregistre les routes pour la gestion de la tombola
func RegisterTombolaRoutes(router *mux.Router, api *swag.API, db *gorm.DB) {
	gormDB := database.NewGormDB(db)

	api.AddEndpoint(
		endpoint.New(
			"POST", "/enter-tombola",
			endpoint.Handler(http.HandlerFunc(controllers.EnterTombolaHandler(gormDB))),
			endpoint.Summary("Enter tombola"),
			endpoint.Description("Allows students to enter the tombola"),
			endpoint.Body(struct {
				StudentID uint `json:"student_id"`
				Tickets   int  `json:"tickets"`
			}{}, "Tombola entry data", true),
			endpoint.Response(200, "Successfully entered the tombola", nil),
			endpoint.Tags("Tombola"),
		),
		endpoint.New(
			"POST", "/draw-tombola",
			endpoint.Handler(http.HandlerFunc(controllers.DrawTombolaHandler(gormDB))),
			endpoint.Summary("Draw tombola"),
			endpoint.Description("Allows organizers to draw the tombola winner"),
			endpoint.Response(200, "Tombola winner drawn", nil),
			endpoint.Tags("Tombola"),
		),
	)

	api.Walk(func(path string, e *swag.Endpoint) {
		h := e.Handler.(http.HandlerFunc)
		router.Path(path).Methods(e.Method).Handler(h)
	})
}
