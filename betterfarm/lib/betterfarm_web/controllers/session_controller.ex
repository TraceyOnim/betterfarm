defmodule BetterfarmWeb.SessionController do
  use BetterfarmWeb, :controller

  alias BetterfarmWeb.Auth

  def new(conn, _param) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Auth.login_by_email_and_password(conn, email, password) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back")
        |> redirect(to: "/")

      {:error, _, conn} ->
        conn
        |> put_flash(:error, "Invalid username/ password")
        |> render("new.html")
    end
  end

  def delete(conn, _param) do
    conn
    |> Auth.logout()
    |> redirect(to: "/")
  end
end
