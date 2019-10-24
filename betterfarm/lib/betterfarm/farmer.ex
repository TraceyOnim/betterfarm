defmodule Betterfarm.Farmer do
  @moduledoc """
  This is a farmer schema.It defines the fields which is the farmer's data and their datatypes

  """
  use Ecto.Schema
  import Ecto.Changeset

  alias BetterFarm.Product

  schema "farmers" do
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string
    field :email_address, :string
    field :nationality, :string
    field :county, :string
    field :country, :string
    field :gender, :string

    timestamps()
  end

  def changeset(farmer, attrs \\ %{}) do
    farmer
    |> cast(attrs, [
      :first_name,
      :last_name,
      :phone_number,
      :email_address,
      :nationality,
      :county,
      :gender
    ])
    |> validate_required([:first_name, :last_name, :phone_number])
  end
end
