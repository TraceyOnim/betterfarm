defmodule Betterfarm.Multimedia.Video do
  @moduledoc """
  Video schema, defines the fields of the video and their datatype
  """
  use Ecto.Schema

  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string
    belongs_to :farmer, Betterfarm.Farmer

    timestamps()
  end
end
