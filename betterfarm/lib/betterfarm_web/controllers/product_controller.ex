defmodule BetterfarmWeb.ProductController do
  use BetterfarmWeb, :controller

  alias Betterfarm.Product
  alias Betterfarm.ProductAccount

  def new(conn, _param) do
    changeset = ProductAccount.change_product(%Product{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"product" => product}) do
    case ProductAccount.create_product(product) do
      {:ok, _product} ->
        conn
        |> put_flash(:info, "product added successfully")
        |> redirect(to: Routes.product_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Something went wrong, Try Again")
        |> render("new.html", changeset: changeset)
    end
  end

  def index(conn, _param) do
    render(conn, "index.html")
  end
end
