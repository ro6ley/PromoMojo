defmodule PromoMojo.Repo do
  use Ecto.Repo,
    otp_app: :promo_mojo,
    adapter: Ecto.Adapters.Postgres
end
