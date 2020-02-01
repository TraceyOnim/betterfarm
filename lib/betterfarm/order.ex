defmodule Betterfarm.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias Betterfarm.LineItem

  schema "order" do
    field :status, :string
    field :total, :float
    embeds_many :line_items, LineItem, on_replace: :delete

    timestamps()
  end
end
