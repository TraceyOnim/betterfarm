defmodule Betterfarm.Repo.Migrations.AddSlugTo_Multimedia_Video do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add :slug, :string
    end
  end
end
