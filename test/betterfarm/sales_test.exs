defmodule Betterfarm.SalesTest do
  use Betterfarm.DataCase

  import Betterfarm.Factory
  alias Betterfarm.Order
  alias Betterfarm.Sales

  test "create_cart/0" do
    assert %Order{status: "In Cart"} = Sales.create_cart()
  end

  test "get_cart/1" do
    # create cart
    cart = Sales.create_cart()
    # get cart
    %Order{status: "In Cart"} = Sales.get_cart(cart.id)
  end

  test "add_to_cart/2" do
    # create product
    {:ok, product} = insert!(:product)
    # create cart
    cart = Sales.create_cart()
    # add to cart
    {:ok, cart} =
      Sales.add_to_cart(cart, %{
        "product_id" => product.id,
        "quantity" => 2,
        "product_name" => product.name
      })

    assert [line_items] = cart.line_items
    assert line_items.product_id == product.id
    assert line_items.unit_price == product.price
    assert line_items.total == 2 * product.price
  end
end
