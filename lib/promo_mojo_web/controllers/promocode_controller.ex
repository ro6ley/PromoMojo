defmodule PromoMojoWeb.PromocodeController do
  use PromoMojoWeb, :controller

  alias PromoMojo.PromoCodes
  alias PromoMojo.PromoCodes.Promocode

  action_fallback PromoMojoWeb.FallbackController

  def index(conn, _params) do
    promocodes = PromoCodes.list_promocodes()
    render(conn, "index.json", promocodes: promocodes)
  end

  def create(conn, %{"promocode" => promocode_params}) do
    IO.inspect(promocode_params, label: "promocode_params")
    with {:ok, %Promocode{} = promocode} <- PromoCodes.create_promocode(promocode_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.promocode_path(conn, :show, promocode))
      |> render("show.json", promocode: promocode)
    end
  end

  def show(conn, %{"id" => id}) do
    promocode = PromoCodes.get_promocode!(id)
    render(conn, "show.json", promocode: promocode)
  end

  def update(conn, %{"id" => id, "promocode" => promocode_params}) do
    promocode = PromoCodes.get_promocode!(id)

    with {:ok, %Promocode{} = promocode} <- PromoCodes.update_promocode(promocode, promocode_params) do
      render(conn, "show.json", promocode: promocode)
    end
  end

  def delete(conn, %{"id" => id}) do
    promocode = PromoCodes.get_promocode!(id)

    with {:ok, %Promocode{}} <- PromoCodes.delete_promocode(promocode) do
      send_resp(conn, :no_content, "")
    end
  end
end
