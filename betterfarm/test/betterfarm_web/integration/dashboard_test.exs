defmodule BetterfarmWeb.DashboardTest do
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
    [farmer: farmer]
  end

  describe "dashboard" do
    test "user can see a home link on the dashboard", %{conn: conn} do
      conn
      |> get(Routes.page_path(conn, :index))
      |> assert_response(html: "Home")
    end

    test "user is redirected to homepage when they click home link", %{
      conn: conn,
      farmer: farmer
    } do
      conn
      |> _sign_in_user(farmer)
      |> get(Routes.farmer_path(conn, :edit, farmer.id))
      |> follow_link("Home")
      |> assert_response(path: Routes.page_path(conn, :index), html: "What is Betterfarm?")
    end

    test "user can see a profile link on the homepage", %{conn: conn, farmer: farmer} do
      conn
      |> _sign_in_user(farmer)
      |> get(Routes.page_path(conn, :index))
      |> assert_response(html: "Profile")
    end

    test "user is redirected to edit page when they click setting link", %{
      conn: conn,
      farmer: farmer
    } do
      conn
      |> _sign_in_user(farmer)
      |> follow_link("Setting")
      |> assert_response(html: "Update")
    end

    test "user is redirected to video page where they can see list of all videos shared", %{
      conn: conn,
      farmer: farmer
    } do
      conn
      |> _sign_in_user(farmer)
      |> follow_link("Videos")
      |> assert_response(
        path: Routes.farmer_video_path(conn, :index, farmer.id),
        html: "Available videos"
      )
    end
  end

  defp _sign_in_user(conn, user) do
    conn
    |> get(Routes.session_path(conn, :new))
    |> follow_form(%{session: %{email: user.credential.email, password: "secret"}})
  end
end
