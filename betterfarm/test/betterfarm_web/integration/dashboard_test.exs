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

  test "user can see a profile link on the homepage", %{conn: conn, farmer: farmer} do
    conn
    |> _sign_in_user(farmer)
    |> get(Routes.page_path(conn, :index))
    |> assert_response(html: "Profile")
  end

  defp _sign_in_user(conn, user) do
    conn
    |> get(Routes.session_path(conn, :new))
    |> follow_form(%{session: %{email: user.credential.email, password: "secret"}})
  end
end
