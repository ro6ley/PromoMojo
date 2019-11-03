defmodule PromoMojo.PromoCodesTest do
  use PromoMojo.DataCase

  alias PromoMojo.PromoCodes

  describe "promocodes" do
    alias PromoMojo.PromoCodes.Promocode

    @valid_attrs %{code: "some code", expiry: ~N[2010-04-17 14:00:00], is_active: true, location: "120.5", radius: 120.5, radius_unit: "some radius_unit", value: 42}
    @update_attrs %{code: "some updated code", expiry: ~N[2011-05-18 15:01:01], is_active: false, location: "456.7", radius: 456.7, radius_unit: "some updated radius_unit", value: 43}
    @invalid_attrs %{code: nil, expiry: nil, is_active: nil, location: nil, radius: nil, radius_unit: nil, value: nil}

    def promocode_fixture(attrs \\ %{}) do
      {:ok, promocode} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PromoCodes.create_promocode()

      promocode
    end

    test "list_promocodes/0 returns all promocodes" do
      promocode = promocode_fixture()
      assert PromoCodes.list_promocodes() == [promocode]
    end

    test "get_promocode!/1 returns the promocode with given id" do
      promocode = promocode_fixture()
      assert PromoCodes.get_promocode!(promocode.id) == promocode
    end

    test "create_promocode/1 with valid data creates a promocode" do
      assert {:ok, %Promocode{} = promocode} = PromoCodes.create_promocode(@valid_attrs)
      assert promocode.code == "some code"
      assert promocode.expiry == ~N[2010-04-17 14:00:00]
      assert promocode.is_active == true
      assert promocode.location == "120.5"
      assert promocode.radius == 120.5
      assert promocode.radius_unit == "some radius_unit"
      assert promocode.value == 42
    end

    test "create_promocode/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PromoCodes.create_promocode(@invalid_attrs)
    end

    test "update_promocode/2 with valid data updates the promocode" do
      promocode = promocode_fixture()
      assert {:ok, %Promocode{} = promocode} = PromoCodes.update_promocode(promocode, @update_attrs)
      assert promocode.code == "some updated code"
      assert promocode.expiry == ~N[2011-05-18 15:01:01]
      assert promocode.is_active == false
      assert promocode.location == "456.7"
      assert promocode.radius == 456.7
      assert promocode.radius_unit == "some updated radius_unit"
      assert promocode.value == 43
    end

    test "update_promocode/2 with invalid data returns error changeset" do
      promocode = promocode_fixture()
      assert {:error, %Ecto.Changeset{}} = PromoCodes.update_promocode(promocode, @invalid_attrs)
      assert promocode == PromoCodes.get_promocode!(promocode.id)
    end

    test "delete_promocode/1 deletes the promocode" do
      promocode = promocode_fixture()
      assert {:ok, %Promocode{}} = PromoCodes.delete_promocode(promocode)
      assert_raise Ecto.NoResultsError, fn -> PromoCodes.get_promocode!(promocode.id) end
    end

    test "change_promocode/1 returns a promocode changeset" do
      promocode = promocode_fixture()
      assert %Ecto.Changeset{} = PromoCodes.change_promocode(promocode)
    end
  end
end
