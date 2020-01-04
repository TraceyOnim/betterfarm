defmodule Betterfarm.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
    end

    create unique_index(:categories, [:name])
  end
end
