defmodule BetterfarmWeb.VideoController do
  use BetterfarmWeb, :controller

  alias Betterfarm.Multimedia.Video
  alias Betterfarm.Multimedia.VideoAccount

  plug :authenticate when action in [:new, :index, :edit, :delete]

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

  def index(conn, %{"farmer_id" => farmer_id}) do
    videos = VideoAccount.list_videos()
    render(conn, "index.html", videos: videos, farmer_id: farmer_id)
  end

  def edit(conn, %{"farmer_id" => farmer_id, "id" => id}) do
    {id, _} = Integer.parse(id)
    video = VideoAccount.get_video(id)
    changeset = Video.changeset(video)
    render(conn, "edit.html", video: video, farmer_id: farmer_id, changeset: changeset)
  end

  def update(conn, %{"farmer_id" => farmer_id, "id" => id, "video" => attrs}) do
    {id, _} = Integer.parse(id)
    video = VideoAccount.get_video(id)

    case VideoAccount.update_video(video, attrs) do
      {:ok, _video} ->
        conn
        |> put_flash(:info, "video updated successfully")
        |> redirect(to: Routes.farmer_video_path(conn, :index, farmer_id))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Something went wrong, Try Again!!")
        |> render("edit.html", changeset: changeset, video: video, farmer_id: farmer_id)
    end
  end

  def delete(conn, %{"farmer_id" => farmer_id, "id" => id}) do
    {id, _} = Integer.parse(id)
    video = VideoAccount.get_video(id)

    case VideoAccount.delete_video(video) do
      {:ok, error} ->
        conn
        |> put_flash(:info, "video has been deleted successfully")
        |> redirect(to: Routes.farmer_video_path(conn, :index, farmer_id))

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Something went wrong, Try Again")
        |> redirect(to: Routes.farmer_video_path(conn, :index, farmer_id))
    end
  end
end
