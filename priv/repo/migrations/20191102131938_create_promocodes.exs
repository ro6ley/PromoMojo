defmodule PromoMojo.Repo.Migrations.CreatePromocodes do
  use Ecto.Migration

  def change do
    create table(:promocodes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :code, :string
      add :value, :integer
      add :radius, :float
      add :radius_unit, :string
      add :is_active, :boolean, default: false, null: false
      add :expiry, :naive_datetime
      add :location, :string

      timestamps()
    end

    create unique_index(:promocodes, [:code])
  end
end
