defmodule Betterfarm.LineItem do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :product_id, :integer
    field :product_name, :string
    field :quantity, :integer
    field :unit_price, :float
    field :total, :float
  end

  def changeset(line_item, attr \\ %{}) do
    line_item
    |> cast(attr, [:product_id, :product_name, :quantity, :unit_price, :total])
  end
end
