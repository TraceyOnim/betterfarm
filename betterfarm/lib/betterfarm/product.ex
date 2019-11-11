defmodule Betterfarm.Product do
  use Ecto.Schema
  import Ecto.Changeset

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

  def changeset(product, attrs \\ %{}) do
    product
    |> cast(attrs, [
      :name,
      :price,
      :location,
      :description,
      :image,
      :quantity,
      :category,
      :farmer_id
    ])
  end
end
