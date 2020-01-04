defmodule Betterfarm.Repo.Migrations.CreateProductNames do
  use Ecto.Migration

  def change do
    create table(:product_names) do
      add :name, :string
    end
  end
end
