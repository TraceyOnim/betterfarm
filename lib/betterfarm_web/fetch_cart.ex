defmodule BetterfarmWeb.FetchCart do
  import Plug.Conn
  alias Betterfarm.Sales

  def init(_opts), do: nil

  def call(conn, _) do
    with cart_id <- get_session(conn, :cart_id),
         true <- is_integer(cart_id),
         cart <- Sales.get_cart(cart_id) do
      assign(conn, :cart, cart)
    else
      _ ->
        cart = Sales.create_cart()

        conn
        |> put_session(:cart_id, cart.id)
        |> assign(:cart, cart)
    end
  end
end
