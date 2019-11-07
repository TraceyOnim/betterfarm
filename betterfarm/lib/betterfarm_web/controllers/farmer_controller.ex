defmodule BetterfarmWeb.FarmerController do
  use BetterfarmWeb, :controller

  alias Betterfarm.Account

  plug :authenticate when action in [:index]

  def new(conn, _param) do
    changeset = Account.change_user()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"farmer" => farmer}) do
    case Account.register_farmer(farmer) do
      {:ok, farmer} ->
        conn
        |> put_flash(:info, "#{farmer.first_name} created successfully")
        |> redirect(to: Routes.farmer_path(conn, :new))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def index(conn, _param) do
    farmers = Account.list_farmers()
    render(conn, "index.html", farmers: farmers)
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end
  end
end
