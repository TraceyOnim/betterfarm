defmodule Betterfarm.Factory do
  alias Betterfarm.Multimedia.Video
  alias Betterfarm.Repo

  def build(:video) do
    %Video{
      url: "http://example.com",
      title: "New farming technology"
    }
  end

  # convenience for building struct with specific attributes
  def build(factory_name, attributes) do
    factory_name |> build() |> struct(attributes)
  end

  # inserts data directly to the repository 
  def insert!(factory_name, attributes \\ []) do
    Repo.insert!(build(factory_name, attributes))
  end
end
