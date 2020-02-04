defmodule Betterfarm.Factory do
  @moduledoc """
  Test factory module necessary for creating data needed for test
  """
  alias Betterfarm.Credential
  alias Betterfarm.Farmer
  alias Betterfarm.Multimedia.Video
  alias Betterfarm.Repo
  alias Betterfarm.Farmer
  alias Betterfarm.Product
  alias Betterfarm.ProductName

  def build(:video) do
    %Video{
      url: "http://example#{System.unique_integer()}.com",
      title: "New farming#{System.unique_integer()} technology"
    }
  end

  def build(:product_name) do
    %ProductName{
      name: "sukuma#{System.unique_integer()}"
    }
  end

  def build(:farmer) do
    %Farmer{
      first_name: "Tracey",
      last_name: "Pendo",
      phone_number: "254#{100_000_000..999_999_999 |> Enum.random() |> to_string()}"
    }
  end

  def build(:product) do
    {:ok, farmer} = insert!(:farmer)
    {:ok, product_name} = insert!(:product_name)

    %Product{
      name: product_name.name,
      price: 100.00,
      farmer_id: farmer.id
    }
  end

  # convenience for building struct with specific attributes
  def build(factory_name, attributes) do
    factory_name |> build() |> struct(attributes)
  end

  # inserts data directly to the repository 
  def insert!(factory_name, attributes \\ []) do
    result = Repo.insert!(build(factory_name, attributes))
    {:ok, result}
  end
end
