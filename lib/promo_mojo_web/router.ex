defmodule PromoMojoWeb.Router do
  use PromoMojoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PromoMojoWeb do
    pipe_through :api
    # fetch all active promocodes
    get "/promocodes/active", PromocodeController, :active
    # redeem a promocode
    post "/promocodes/redeem", PromocodeController, :redeem

    resources "/promocodes", PromocodeController

  end
end
