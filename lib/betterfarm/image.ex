defmodule Betterfarm.Image do
  use Arc.Ecto.Schema
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :avatar, Betterfarm.Avatar.Type
    field :uuid, :string
    belongs_to :product, Betterfarm.Product
  end

  @doc """
  Creates a changeset based on the `data` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(image, params \\ :invalid) do
    image
    |> cast(params, [:product_id, :uuid])
    |> cast_attachments(params, [:avatar])
    |> validate_required([:avatar])
  end
end
