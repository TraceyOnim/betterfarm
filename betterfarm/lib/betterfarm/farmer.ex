defmodule Betterfarm.Farmer do
  @moduledoc """
  This is a farmer schema.It defines the fields which is the farmer's data and their datatypes

  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Betterfarm.Credential

  schema "farmers" do
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string
    field :nationality, :string
    field :county, :string
    field :country, :string
    field :gender, :string
    field :slug, :string
    has_one :credential, Credential
    has_many :products, Betterfarm.Product
    has_many :videos, Betterfarm.Multimedia.Video

    timestamps()
  end

  def changeset(farmer, attrs \\ %{}) do
    farmer
    |> cast(attrs, [
      :first_name,
      :last_name,
      :phone_number,
      :nationality,
      :county,
      :country,
      :gender
    ])
    |> validate_required([:first_name, :last_name, :phone_number])
    |> slugify_farmer_id()
  end

  def slugify_farmer_id(changeset) do
    case fetch_change(changeset, :county) do
      {:ok, county_value} -> put_change(changeset, :slug, slugify(county_value))
      :error -> changeset
    end
  end

  defp slugify(value) do
    "farmer-in-" <> value <> "-" <> Ecto.UUID.generate()
  end

  def registration_changeset(farmer, attrs \\ %{}) do
    farmer
    |> changeset(attrs)
    |> cast_assoc(:credential, with: &Credential.changeset/2, required: true)
  end

  defimpl Phoenix.Param do
    def to_param(%{slug: slug, id: id}), do: "#{id}-#{slug}"
  end
end
