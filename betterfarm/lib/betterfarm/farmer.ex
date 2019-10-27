defmodule Betterfarm.Farmer do
  @moduledoc """
  This is a farmer schema.It defines the fields which is the farmer's data and their datatypes

  """
  use Ecto.Schema
  import Ecto.Changeset

  alias BetterFarm.Product
  alias Betterfarm.Credential

  schema "farmers" do
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string
    field :nationality, :string
    field :county, :string
    field :country, :string
    field :gender, :string
    has_one :credential, Credential

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
      :gender
    ])
    |> validate_required([:first_name, :last_name, :phone_number])
  end

  def registration_changeset(farmer, attrs \\ %{}) do
    farmer
    |> changeset(attrs)
    |> cast_assoc(:credential, with: &Credential.changeset/2, required: true)
  end
end
