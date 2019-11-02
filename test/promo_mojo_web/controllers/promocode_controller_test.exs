defmodule PromoMojoWeb.PromocodeControllerTest do
  use PromoMojoWeb.ConnCase

  alias PromoMojo.PromoCodes
  alias PromoMojo.PromoCodes.Promocode

  @create_attrs %{
    code: "some code",
    expiry: ~N[2010-04-17 14:00:00],
    is_active: true,
    location_latitude: 120.5,
    location_longitude: 120.5,
    radius: 120.5,
    radius_unit: "some radius_unit",
    value: 42
  }
  @update_attrs %{
    code: "some updated code",
    expiry: ~N[2011-05-18 15:01:01],
    is_active: false,
    location_latitude: 456.7,
    location_longitude: 456.7,
    radius: 456.7,
    radius_unit: "some updated radius_unit",
    value: 43
  }
  @invalid_attrs %{code: nil, expiry: nil, is_active: nil, location_latitude: nil, location_longitude: nil, radius: nil, radius_unit: nil, value: nil}

  def fixture(:promocode) do
    {:ok, promocode} = PromoCodes.create_promocode(@create_attrs)
    promocode
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all promocodes", %{conn: conn} do
      conn = get(conn, Routes.promocode_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create promocode" do
    test "renders promocode when data is valid", %{conn: conn} do
      conn = post(conn, Routes.promocode_path(conn, :create), promocode: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.promocode_path(conn, :show, id))

      assert %{
               "id" => id,
               "code" => "some code",
               "expiry" => "2010-04-17T14:00:00",
               "is_active" => true,
               "location_latitude" => 120.5,
               "location_longitude" => 120.5,
               "radius" => 120.5,
               "radius_unit" => "some radius_unit",
               "value" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.promocode_path(conn, :create), promocode: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promocode" do
    setup [:create_promocode]

    test "renders promocode when data is valid", %{conn: conn, promocode: %Promocode{id: id} = promocode} do
      conn = put(conn, Routes.promocode_path(conn, :update, promocode), promocode: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.promocode_path(conn, :show, id))

      assert %{
               "id" => id,
               "code" => "some updated code",
               "expiry" => "2011-05-18T15:01:01",
               "is_active" => false,
               "location_latitude" => 456.7,
               "location_longitude" => 456.7,
               "radius" => 456.7,
               "radius_unit" => "some updated radius_unit",
               "value" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, promocode: promocode} do
      conn = put(conn, Routes.promocode_path(conn, :update, promocode), promocode: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete promocode" do
    setup [:create_promocode]

    test "deletes chosen promocode", %{conn: conn, promocode: promocode} do
      conn = delete(conn, Routes.promocode_path(conn, :delete, promocode))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.promocode_path(conn, :show, promocode))
      end
    end
  end

  defp create_promocode(_) do
    promocode = fixture(:promocode)
    {:ok, promocode: promocode}
  end
end
