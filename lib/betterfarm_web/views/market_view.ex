defmodule BetterfarmWeb.MarketView do
  use BetterfarmWeb, :view

  alias Betterfarm.Product.Catalog

  def product_image(product) do
    product = Catalog.preload_product(product)

    case product.images do
      [] ->
        "/avatars/user.png"

      _ ->
        Enum.map(product.images, fn image -> "/uploads/#{image.avatar}" end) |> Enum.random()
    end
  end

  def product_name(name) do
    Catalog.get_product_name(name)
  end
end
