defmodule Betterfarm.Repo.Migrations.CreateOrderTable do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :status, :string
      add :total, :float
      add :line_items, {:array, :map}

      timestamps()
    end
  end
end
