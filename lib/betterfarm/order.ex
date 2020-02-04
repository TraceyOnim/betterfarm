defmodule Betterfarm.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias Betterfarm.LineItem

  schema "orders" do
    field :status, :string
    field :total, :float
    embeds_many :line_items, LineItem, on_replace: :delete

    timestamps()
  end

  def changeset(order, attrs \\ %{}) do
    order
    |> cast(attrs, [:status, :total])
    |> cast_embed(:line_items, required: true, with: &LineItem.changeset/2)
    |> set_order_total()
  end

  def set_order_total(changeset) do
    items = get_field(changeset, :line_items)
    total = Enum.reduce(items, 0, fn item, acc -> acc + item.total end)
    put_change(changeset, :total, total)
  end
end
