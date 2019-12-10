defmodule BetterfarmWeb.FarmerController do
  use BetterfarmWeb, :controller

  alias Betterfarm.Account

  plug :authenticate when action in [:index, :show, :edit]

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

  def show(conn, %{"id" => id}) do
    farmer = Account.get_farmer(id)
    render(conn, "show.html", farmer: farmer)
  end

  def edit(conn, %{"id" => id}) do
    farmer = Account.preload_farmer_credential(id)
    changeset = Betterfarm.Farmer.changeset(farmer)
    render(conn, "edit.html", changeset: changeset, farmer: farmer)
  end
end
