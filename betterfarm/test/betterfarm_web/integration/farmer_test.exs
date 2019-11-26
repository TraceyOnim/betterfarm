defmodule BetterfarmWeb.FarmerTest do
  use BetterfarmWeb.IntegrationCase

  describe "create farmer" do
    test "user can see register link", %{conn: conn} do
      conn
      |> get(Routes.page_path(conn, :index))
      |> assert_response(html: "Register")
    end

    test "user is redirected to registration page on click of register link", %{conn: conn} do
      conn
      |> get(Routes.page_path(conn, :index))
      |> click_link("Register")
      |> assert_response(html: "Register Farmer", path: "/farmers/new")
    end
  end
end
