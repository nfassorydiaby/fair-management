	package routes

	import (
		"backend/internal/controllers"
		"backend/internal/database"
		"log"
		"github.com/gorilla/mux"
		"github.com/zc2638/swag"
		"github.com/zc2638/swag/endpoint"
		"gorm.io/gorm"
		"net/http"
	)

	// RegisterTokenRoutes enregistre les routes pour la gestion des jetons
	func RegisterTokenRoutes(router *mux.Router, api *swag.API, db *gorm.DB) {

		gormDB := database.NewGormDB(db)

		api.AddEndpoint(
			endpoint.New(
				http.MethodPost, "/buy-tokens",
				endpoint.Handler(http.HandlerFunc(controllers.BuyTokensHandler(gormDB))),
				endpoint.Summary("Buy tokens"),
				endpoint.Description("Allows parents to buy tokens"),
				endpoint.Body(struct {
					ParentID uint `json:"parent_id"`
					Amount   int  `json:"amount"`
				}{}, "Token purchase data", true),
				endpoint.Response(http.StatusOK, "Tokens successfully purchased", nil),
				endpoint.Tags("Tokens"),
			),
			endpoint.New(
				http.MethodPost, "/distribute-tokens",
				endpoint.Handler(http.HandlerFunc(controllers.GiveTokensHandler(gormDB))),
				endpoint.Summary("Distribute tokens"),
				endpoint.Description("Allows parents to distribute tokens to their children"),
				endpoint.Body(struct {
					ParentID   uint `json:"parent_id"`
					StudentID  uint `json:"student_id"`
					TokenCount int  `json:"token_count"`
				}{}, "Token distribution data", true),
				endpoint.Response(http.StatusOK, "Tokens successfully distributed", nil),
				endpoint.Tags("Tokens"),
			),
		)

		// Vérifiez que le handler n'est pas nil avant de le cast en http.HandlerFunc
		api.Walk(func(path string, e *swag.Endpoint) {
			handlerFunc, ok := e.Handler.(http.HandlerFunc)
			if !ok {
				log.Fatalf("Unable to cast handler for path %s", path)
			}
			router.Path(path).Methods(e.Method).Handler(handlerFunc)
		})
	}
