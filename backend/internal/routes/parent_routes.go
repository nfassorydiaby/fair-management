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

// RegisterParentRoutes enregistre les routes pour les parents
func RegisterParentRoutes(router *mux.Router, api *swag.API, db *gorm.DB) {
	gormDB := database.NewGormDB(db)

	api.AddEndpoint(
		endpoint.New(
			"POST", "/get-children",
			endpoint.Handler(http.HandlerFunc(controllers.GetChildrenHandler(gormDB))),
			endpoint.Summary("Get children"),
			endpoint.Description("Allows parents to retrieve their children's details and tokens"),
			endpoint.Body(struct {
				ParentID uint `json:"parent_id"`
			}{}, "Parent ID data", true),
			endpoint.Response(200, "Successfully retrieved children details", nil),
			endpoint.Tags("Parent"),
		),
	)

	api.Walk(func(path string, e *swag.Endpoint) {
		h := e.Handler.(http.HandlerFunc)
		router.Path(path).Methods(e.Method).Handler(h)
	})
}
