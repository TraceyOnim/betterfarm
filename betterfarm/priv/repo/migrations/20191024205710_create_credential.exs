defmodule Betterfarm.Repo.Migrations.CreateCredential do
  use Ecto.Migration

  def change do
    create table(:credentials) do
      add :email, :string
      add :password_hash, :string
      add :farmer_id, references(:farmers, on_delete: :delete_all, null: false)

      timestamps()
    end
  end
end
