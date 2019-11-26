defmodule BetterfarmWeb.ProductView do
  use BetterfarmWeb, :view

  alias Betterfarm.ProductAccount

  def product_name do
    ProductAccount.list_product_name()
  end

  def category_name do
    ProductAccount.list_category_name()
  end
end
