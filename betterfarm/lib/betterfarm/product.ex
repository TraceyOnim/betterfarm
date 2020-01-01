defmodule Betterfarm.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :price, :float
    field :location, :string
    field :description, :string
    field :image, :string
    field :quantity, :float
    field :unit, :string
    field :category, :string
    belongs_to :farmer, Betterfarm.Farmer

    timestamps()
  end

  def changeset(product, attrs \\ %{}) do
    field = [
      :name,
      :price,
      :location,
      :description,
      :quantity,
      :unit,
      :category
    ]

    product
    |> cast(attrs, field ++ [:farmer_id])
    |> validate_required(field)
  end
end
