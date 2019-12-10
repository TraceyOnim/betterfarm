defmodule BetterfarmWeb.FarmerTest do
  use BetterfarmWeb.IntegrationCase

  alias Betterfarm.Account

  setup do
    farmer_attr = %{
      first_name: "first",
      last_name: "last",
      phone_number: "0718039045",
      national_id: "1234567",
      country: "Kenya",
      county: "Kisumu",
      gender: "female",
      credential: %{email: "firstlast@email.com", password: "secret"}
    }

    {:ok, farmer} = Account.register_farmer(farmer_attr)
    [farmer: farmer, farmer_attr: farmer_attr]
  end

  describe "home page" do
    test "user can see register link", %{conn: conn} do
      conn
      |> get(Routes.page_path(conn, :index))
      |> assert_response(html: "Sign Up")
    end

    test "user can see log in link", %{conn: conn} do
      conn
      |> get(Routes.page_path(conn, :index))
      |> assert_response(html: "Log in")
    end
  end

  describe "farmer registration" do
    test "user is redirected to registration page on click of sign up link", %{conn: conn} do
      conn
      |> get(Routes.page_path(conn, :index))
      |> click_link("Sign Up")
      |> assert_response(html: "Register Farmer", path: "/farmers/new")
    end

    test "farmer can be registered", %{conn: conn, farmer_attr: farmer_attr} do
      conn
      |> get(Routes.farmer_path(conn, :new))
      |> follow_form(%{farmer: farmer_attr})
      |> assert_response(html: "created successfully", status: 200)
    end
  end

  describe "list of farmers" do
    test "when user clicks farmers is redirected to a page with a list of farmers", %{
      conn: conn,
      farmer: farmer
    } do
      conn
      |> _sign_in_user(farmer)
      |> follow_link("Connect")
      |> assert_response(html: "Available farmers", path: "/farmers")
    end

    test "when user clicks on view is redirected to a page with farmers details", %{
      conn: conn,
      farmer: farmer
    } do
      conn
      |> _sign_in_user(farmer)
      |> get(Routes.farmer_path(conn, :index))
      |> click_link("view")
      |> assert_response(html: "#{farmer.first_name} Details")
    end
  end

  test "user is redirected to edit page when they click settings link", %{
    conn: conn,
    farmer: farmer
  } do
    conn
    |> _sign_in_user(farmer)
    |> get(Routes.farmer_path(conn, :edit, farmer.id))
    |> assert_response(
      html: "Update",
      status: 200,
      path: Routes.farmer_path(conn, :edit, farmer.id)
    )
  end

  test "requires user authentication in order to have access", %{conn: conn} do
    conn
    |> get(Routes.farmer_path(conn, :index))
    |> assert_response(status: 302, assigns: %{current_user: nil})
  end

  defp _sign_in_user(conn, user) do
    conn
    |> get(Routes.session_path(conn, :new))
    |> follow_form(%{session: %{email: user.credential.email, password: "secret"}})
  end
end
