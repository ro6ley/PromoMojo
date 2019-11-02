defmodule PromoMojo.PromoCodes.Promocode do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "promocodes" do
    field :code, :string
    field :expiry, :naive_datetime
    field :is_active, :boolean, default: false
    field :location_latitude, :float
    field :location_longitude, :float
    field :radius, :float
    field :radius_unit, :string
    field :value, :integer

    timestamps()
  end

  @doc false
  def changeset(promocode, attrs) do
    promocode
    |> cast(attrs, [:code, :value, :radius, :radius_unit, :is_active, :expiry, :location_latitude, :location_longitude])
    |> validate_required([:code, :value, :radius, :radius_unit, :is_active, :expiry, :location_latitude, :location_longitude])
    |> unique_constraint(:code)
  end
end
