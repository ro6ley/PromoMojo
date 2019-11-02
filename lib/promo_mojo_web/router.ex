defmodule PromoMojoWeb.Router do
  use PromoMojoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PromoMojoWeb do
    pipe_through :api

    resources "/promocodes", PromocodeController, except: [:new, :edit]
  end
end
