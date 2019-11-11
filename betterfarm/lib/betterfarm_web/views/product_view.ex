defmodule BetterfarmWeb.ProductView do
  use BetterfarmWeb, :view

  alias Betterfarm.Product.Account

  def product_name do
    Account.list_product_name()
  end

  def category_name do
    Account.list_category_name()
  end
end
