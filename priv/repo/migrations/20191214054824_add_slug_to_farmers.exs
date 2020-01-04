defmodule Betterfarm.Repo.Migrations.AddSlugToFarmers do
  use Ecto.Migration

  def change do
    alter table(:farmers) do
      add :slug, :string
    end
  end
end
