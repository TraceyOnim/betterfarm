defmodule BetterfarmWeb.VideoController do
  use BetterfarmWeb, :controller

  alias Betterfarm.Multimedia.Video
  alias Betterfarm.Multimedia.VideoAccount

  plug :authenticate when action in [:new]

  def new(conn, %{"farmer_id" => farmer_id}) do
    changeset = VideoAccount.change_video(%Video{})
    render(conn, "new.html", changeset: changeset, farmer_id: farmer_id)
  end

  def create(conn, %{"farmer_id" => farmer_id, "video" => video}) do
    attrs = Map.merge(video, %{"farmer_id" => farmer_id})

    case VideoAccount.create_video(attrs) do
      {:ok, _video} ->
        conn
        |> put_flash(:info, "video has been shared")
        |> redirect(to: Routes.farmer_video_path(conn, :index, farmer_id))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Something went wrong, Try Again!")
        |> render("new.html", changeset: changeset, farmer_id: farmer_id)
    end
  end

  def index(conn, _param) do
    videos = VideoAccount.list_videos()
    render(conn, "index.html", videos: videos)
  end
end
