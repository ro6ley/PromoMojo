defmodule PromoMojoWeb.PromocodeController do
  use PromoMojoWeb, :controller

  alias PromoMojo.PromoCodes
  alias PromoMojo.PromoCodes.Promocode

  @gmaps_api_key "AIzaSyA_u-LRpaLlQSPaJKL1NnPnGpMIYHRV94Q"
  @gmaps_base_url "https://maps.googleapis.com/maps/api/directions/json"

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

  def active(conn, _params) do
    promocodes = PromoCodes.list_active_promocodes()
    render(conn, "index.json", promocodes: promocodes)
  end

  def redeem(conn, %{"data" => redemption_data}) do
    res_data = %{}
    coordinates = %{origin: redemption_data["origin"], destination: redemption_data["destination"]}
    promocode = PromoCodes.get_promocode_by_code!(redemption_data["promocode"])

    # Check if destination or origin is equal to promocode location
    unless Map.values(coordinates) |> Enum.member?(promocode.location) do
      res_data = Map.put(res_data, :error, "Invalid location")
      render(conn, "redeem.json", res_data: res_data, code: 400)
    end

    # Check if Promocode provided is active
    case promocode.is_active do
      true ->
        # Get the PromoCode details
        promo_details = %{value: promocode.value, radius: promocode.radius, radius_unit: promocode.radius_unit, expiry: promocode.expiry, location: promocode.location}

        # hit G Maps API and get the polyline
        {_, g_maps_response} = gmaps_handler(coordinates)
        [first_route | _tail ] = g_maps_response["routes"]

        res_data = Map.put(res_data, "polyline", first_route["overview_polyline"]["points"])
        res_data = Map.put(res_data, :promo_details, promo_details)
        render(conn, "redeem.json", res_data: res_data, code: 200)

      false ->
        res_data = Map.put(res_data, :error, "Promocode is Inactive")
        render(conn, "redeem.json", res_data: res_data, code: 400)
    end

  end

  defp gmaps_handler(coordinates) do
    url = gmaps_api_url(coordinates)
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        {:ok, Jason.decode!(body) }
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found }
      {:ok, %HTTPoison.Error{reason: reason}} ->
        {:error, reason }
      _ ->
        {:error, "we ran into a problem processing your request"}
    end
  end

  defp gmaps_api_url(coordinates) do
    "#{@gmaps_base_url}?mode=driving&origin=" <> coordinates.origin <> "&destination=" <> coordinates.destination <> "&key=#{@gmaps_api_key}"
  end
end
