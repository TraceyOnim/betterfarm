defmodule BetterfarmWeb.ProductController do
  use BetterfarmWeb, :controller

  alias Betterfarm.Product
  alias Betterfarm.Product.Account

  def new(conn, _param) do
    changeset = Account.change_product(%Product{})
    render(conn, "new.html", changeset: changeset)
  end
end
