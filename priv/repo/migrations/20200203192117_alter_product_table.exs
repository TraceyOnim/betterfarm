defmodule Betterfarm.Repo.Migrations.AlterProductTable do
  use Ecto.Migration

  def change do
    alter table(:products) do
      remove :quantity
    end

    alter table(:products) do
      add :pack_size, :float
    end
  end
end
