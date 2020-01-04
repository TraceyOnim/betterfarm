defmodule Betterfarm.Factory do
  @moduledoc """
  Test factory module necessary for creating data needed for test
  """
  alias Betterfarm.Credential
  alias Betterfarm.Farmer
  alias Betterfarm.Multimedia.Video
  alias Betterfarm.Repo

  def build(:video) do
    %Video{
      url: "http://example#{System.unique_integer()}.com",
      title: "New farming#{System.unique_integer()} technology"
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
