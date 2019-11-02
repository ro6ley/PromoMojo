defmodule PromoMojoWeb.Router do
  use PromoMojoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PromoMojoWeb do
    pipe_through :api
    # fetch all active promocodes
    get "/promocodes/active", PromocodeController, :active

    resources "/promocodes", PromocodeController, except: [:delete]

  end
end
