defmodule BetterfarmWeb.FarmerController do
  use BetterfarmWeb, :controller

  alias Betterfarm.Account

  def new(conn, _param) do
    changeset = Account.change_user()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"farmer" => farmer}) do
    case Account.create_farmer(farmer) do
      {:ok, farmer} ->
        conn
        |> put_flash(:info, "#{farmer.first_name} created successfully")
        |> redirect(to: Routes.farmer_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def index(conn, _param) do
    farmers = Account.list_farmers()
    render(conn, "index.html", farmers: farmers)
  end
end
