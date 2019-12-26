defmodule BetterfarmWeb.MultimediaTest do
  use BetterfarmWeb.IntegrationCase

  import Betterfarm.Factory
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

  describe "video" do
    test "farmer can see Add video link when logged in", %{conn: conn, farmer: farmer} do
      conn
      |> _sign_in_user(farmer)
      |> get(Routes.page_path(conn, :index))
      |> assert_response(html: "Video")
    end

    test "user cannot see Add video link if they are no logged in", %{conn: conn} do
      conn
      |> get(Routes.page_path(conn, :index))
      |> refute_response(html: "Video")
    end

    test "farmer is redirected to new page of the video that contains form for creating video", %{
      conn: conn,
      farmer: farmer
    } do
      conn
      |> _sign_in_user(farmer)
      |> follow_link("Video")
      |> assert_response(html: "Available Videos")
    end

    test "farmer can share video", %{conn: conn, farmer: farmer} do
      conn
      |> _sign_in_user(farmer)
      |> get(Routes.farmer_video_path(conn, :new, farmer.id))
      |> follow_form(%{video: %{url: "http://example.com", title: "New farming technology"}})
      |> assert_response(html: "video has been shared")
    end

    test "farmers can see list of the available videos", %{conn: conn, farmer: farmer} do
      conn
      |> _sign_in_user(farmer)
      |> follow_link("Videos")
      |> assert_response(html: "Available Videos")
    end
  end

  defp _sign_in_user(conn, user) do
    conn
    |> get(Routes.session_path(conn, :new))
    |> follow_form(%{session: %{email: user.credential.email, password: "secret"}})
  end
end
