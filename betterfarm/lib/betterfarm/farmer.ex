defmodule BetterFarm.Farmer do
  @moduledoc """
  This is a farmer schema.It defines the fields which is the farmer's data and their datatypes

  """
  use Ecto.Schema

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
end
