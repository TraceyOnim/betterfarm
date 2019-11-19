defmodule Betterfarm.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :price, :float
      add :location, :string
      add :description, :string
      add :image, :string
      add :quantity, :string
      add :unit, :string
      add :category, :string
      add :farmer_id, references(:farmers)

      timestamps()
    end
  end
end
