defmodule Betterfarm.Product do
  use Ecto.Schema

  schema "products" do
    field :name, :string
    field :price, :float
    field :location, :string
    field :description, :string
    field :image, :string
    field :quantity, :string
    field :category, :string
    belongs_to :farmer, Betterfarm.Farmer

    timestamps()
  end
end
