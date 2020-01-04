defmodule Betterfarm.Repo.Migrations.CreateFarmers do
  use Ecto.Migration

  def change do
    create table(:farmers) do
      add :first_name, :string
      add :last_name, :string
      add :phone_number, :string
      add :nationality, :string
      add :county, :string
      add :country, :string
      add :gender, :string

      timestamps()
    end
  end
end
