defmodule Betterfarm.LineItem do
  use Ecto.Schema
  import Ecto.Changeset
  alias Betterfarm.Product.Catalog

  embedded_schema do
    field :product_id, :integer
    field :product_name, :string
    field :quantity, :integer
    field :unit_price, :float
    field :total, :float
  end

  def changeset(line_item, attr \\ %{}) do
    field = [:product_id, :product_name, :quantity, :unit_price, :total]

    line_item
    |> cast(attr, field)
    |> set_product_details()
    |> set_total()
    |> validate_required(field)
  end

  def set_product_details(changeset) do
    case get_change(changeset, :product_id) do
      nil ->
        changeset

      product_id ->
        product = Catalog.get_product(product_id)

        changeset
        |> put_change(:product_name, product.name)
        |> put_change(:unit_price, product.price)
    end
  end

  def set_total(changeset) do
    quantity = get_field(changeset, :quantity)
    unit_price = get_field(changeset, :unit_price)
    put_change(changeset, :total, quantity * unit_price)
  end
end
