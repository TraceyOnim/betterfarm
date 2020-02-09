defmodule BetterfarmWeb.LayoutView do
  use BetterfarmWeb, :view

  import BetterfarmWeb.CartView, only: [cart_count: 1]

  def cart_link_text(conn) do
    raw("""
    <i class="fa fa-shopping-cart"></i> <span class="cart-
    count">(#{cart_count(conn)})</span>
    """)
  end
end
