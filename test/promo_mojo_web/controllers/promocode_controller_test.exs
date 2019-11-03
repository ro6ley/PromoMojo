defmodule PromoMojoWeb.PromocodeControllerTest do
  use PromoMojoWeb.ConnCase

  alias PromoMojo.PromoCodes
  alias PromoMojo.PromoCodes.Promocode

  @create_attrs %{
    code: "some code",
    expiry: ~N[2010-04-17 14:00:00],
    is_active: true,
    location: "120.5",
    radius: 120.5,
    radius_unit: "some radius_unit",
    value: 42
  }
  @update_attrs %{
    code: "some updated code",
    expiry: ~N[2011-05-18 15:01:01],
    is_active: false,
    location: "456.7",
    radius: 456.7,
    radius_unit: "some updated radius_unit",
    value: 43
  }
  @invalid_attrs %{code: nil, expiry: nil, is_active: nil, location: nil, radius: nil, radius_unit: nil, value: nil}

  @kca_promocode %{
    code: "KCA",
    expiry: ~N[2010-04-17 14:00:00],
    is_active: true,
    location: "KCA+University",
    radius: 12.5,
    radius_unit: "kilometers",
    value: 42
  }

  @trm_promocode %{
    code: "TRM",
    expiry: ~N[2010-04-17 14:00:00],
    is_active: false,
    location: "TRM+-+Thika+Road+Mall",
    radius: 12.5,
    radius_unit: "kilometers",
    value: 42
  }

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
               "location" => "120.5",
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
               "location" => "456.7",
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

  describe "active promocodes" do
    setup [:create_test_promocodes]

    test "returns active promocodes", %{conn: conn} do
      conn = get(conn, Routes.promocode_path(conn, :active))
      assert [%{"code" => "KCA"}] = json_response(conn, 200)["data"]
    end
  end

  describe "promocode redemption" do
    setup [:create_test_promocodes]

    test "active promocode and location returns polyline and promocode data", %{conn: conn} do
      redemption_data = %{data: %{origin: "KCA+University", destination: "TRM+-+Thika+Road+Mall", promocode: "KCA" }}
      conn = post(conn, Routes.promocode_path(conn, :redeem, redemption_data), redemption_data: redemption_data)

      assert %{"code" => 200} = json_response(conn, 200)

    end

    test "active promocode invalid location returns error 400", %{conn: conn} do
      redemption_data = %{data: %{origin: "Safari+Park+Hotel", destination: "TRM+-+Thika+Road+Mall", promocode: "KCA" }}
      conn = post(conn, Routes.promocode_path(conn, :redeem, redemption_data), redemption_data: redemption_data)

      assert %{
        "code" => 400,
        "data" => %{
          "error" => "Invalid location"
        }
      } = json_response(conn, 200)
    end

    test "inactive promocode, valid location returns error 400", %{conn: conn} do
      redemption_data = %{data: %{origin: "KCA+University", destination: "TRM+-+Thika+Road+Mall", promocode: "TRM" }}
      conn = post(conn, Routes.promocode_path(conn, :redeem, redemption_data), redemption_data: redemption_data)

      assert %{
        "code" => 400,
        "data" => %{
          "error" => "Promocode is Inactive"
        }
      } = json_response(conn, 200)
    end

    test "invalid promocode returns error" do
      redemption_data = %{data: %{origin: "KCA+University", destination: "TRM+-+Thika+Road+Mall", promocode: "ALCHEMIST" }}
      conn = post(conn, Routes.promocode_path(conn, :redeem, redemption_data), redemption_data: redemption_data)

      assert %{
        "code" => 404,
        "data" => %{
          "error" => "Promocode not found."
        }
      } = json_response(conn, 404)
    end
  end


  defp create_promocode(_) do
    promocode = fixture(:promocode)
    {:ok, promocode: promocode}
  end

  defp create_test_promocodes(_) do
    test_promocodes = %{}
    {:ok, kca_promocode} = PromoCodes.create_promocode(@kca_promocode)
    test_promocodes = Map.put(test_promocodes, :kca, kca_promocode)

    {:ok, trm_promocode} = PromoCodes.create_promocode(@trm_promocode)
    test_promocodes = Map.put(test_promocodes, :trm, trm_promocode)

    test_promocodes
  end
end
