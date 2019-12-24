defmodule Betterfarm.Multimedia.VideoAccount do
  @moduledoc """
  Account context for video 
  """
  alias Betterfarm.Multimedia.Video
  alias Betterfarm.Repo

  def change_video(video) do
    video
    |> Video.changeset()
  end

  @doc """
  Inserts video into the database. Returns {:ok, video} if the video is succesfully saved into the database. 
  Otherwise {:error, changeset}.

  """
  @spec create_video(map()) :: {:ok, %Video{}} | {:error, %Ecto.Changeset{}}
  def create_video(attrs) do
    %Video{}
    |> Video.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Fetches video from the database whose id given matches.
  Returns nil if no result is found.

  """
  @spec get_video(integer()) :: %Video{} | nil
  def get_video(id) do
    Video
    |> Repo.get(id)
  end

  @doc """
  list_videos/0 returns a list of all videos.

  """
  @spec list_videos() :: [%Video{}, ...]
  def list_videos do
    Video
    |> Repo.all()
  end
end
