defmodule Betterfarm.LineItem do
  use Ecto.Schema

  embedded_schema do
    field :product_id, :integer
    field :product_name, :string
    field :quantity, :integer
    field :unit_price, :float
    field :total, :float
  end
end
