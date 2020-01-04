defmodule Betterfarm.Multimedia.Video do
  @moduledoc """
  Video schema, defines the fields of the video and their datatype
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string
    field :slug, :string
    belongs_to :farmer, Betterfarm.Farmer

    timestamps()
  end

  def changeset(video, attrs \\ %{}) do
    video
    |> cast(attrs, [:url, :title, :description, :farmer_id])
    |> validate_required([:url, :title])
    |> _slugify_title()
  end

  defp _slugify_title(changeset) do
    case fetch_change(changeset, :title) do
      {:ok, new_title} ->
        put_change(changeset, :slug, _slugify(new_title))

      :error ->
        changeset
    end
  end

  defp _slugify(new_title) do
    new_title
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end

  defimpl Phoenix.Param do
    def to_param(%{slug: slug, id: id}), do: "#{id}-#{slug}"
  end
end
