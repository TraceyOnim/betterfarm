defmodule BetterfarmWeb.WatchController do
  use BetterfarmWeb, :controller

  alias Betterfarm.Multimedia.VideoAccount

  def show(conn, %{"id" => id}) do
    {id, _} = Integer.parse(id)
    video = VideoAccount.get_video(id)
    render(conn, "show.html", video: video)
  end
end
