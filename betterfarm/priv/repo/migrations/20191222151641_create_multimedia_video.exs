defmodule Betterfarm.Repo.Migrations.CreateMultimediaVideo do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :url, :string
      add :title, :string
      add :description, :string
      add :farmer_id, references(:farmers)

      timestamps()
    end
  end
end
