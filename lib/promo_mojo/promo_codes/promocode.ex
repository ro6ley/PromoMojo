defmodule PromoMojo.PromoCodes.Promocode do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "promocodes" do
    field :code, :string
    field :expiry, :naive_datetime
    field :is_active, :boolean, default: false
    field :location, :string
    field :radius, :float
    field :radius_unit, :string
    field :value, :integer

    timestamps()
  end

  @doc false
  def changeset(promocode, attrs) do
    promocode
    |> cast(attrs, [:code, :value, :radius, :radius_unit, :is_active, :expiry, :location])
    |> validate_required([:code, :value, :radius, :radius_unit, :is_active, :expiry, :location])
    |> unique_constraint(:code)
  end
end
