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
    {:ok, video} = insert!(:video, farmer_id: farmer.id)
    [farmer: farmer, video: video]
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

    test "farmer is redirected to edit page on clicking edit button", %{
      conn: conn,
      farmer: farmer
    } do
      conn
      |> _sign_in_user(farmer)

      # create video
      {:ok, video} = insert!(:video, farmer_id: farmer.id)

      conn
      |> _sign_in_user(farmer)
      |> get(Routes.farmer_video_path(conn, :index, farmer.id))
      |> follow_link("Edit")
      |> assert_response(html: "Edit")
    end

    test "farmer can update video", %{conn: conn, farmer: farmer, video: video} do
      conn
      |> _sign_in_user(farmer)
      |> get(Routes.farmer_video_path(conn, :edit, farmer.id, video.id))
      |> follow_form(%{video: %{title: "Best technology"}})
      |> assert_response(html: "video updated successfully")
    end
  end

  defp _sign_in_user(conn, user) do
    conn
    |> get(Routes.session_path(conn, :new))
    |> follow_form(%{session: %{email: user.credential.email, password: "secret"}})
  end
end
