defmodule BetterfarmWeb.ProductView do
  use BetterfarmWeb, :view

  alias Betterfarm.Product.Catalog

  def product_name do
    Catalog.list_product_name()
  end

  def category_name do
    Catalog.list_category_name()
  end
end
