defmodule Betterfarm.Sales do
  @moduledoc """
    sales context
  """
  alias Betterfarm.Order
  alias Betterfarm.Repo

  @doc """
  Returns order changeset
  """
  def change_cart(%Order{} = order) do
    Order.changeset(order)
  end

  @doc """
  creates an order with status "In Cart"
  """
  def create_cart do
    %Order{status: "In Cart"} |> Repo.insert!()
  end

  @doc """
  Fetches the cart whose id given matches
  """
  def get_cart(id) do
    Order
    |> Repo.get(id)
  end

  def update_cart(cart, attrs) do
    cart
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  updates cart with a list of line_items corresponding to the product added
  """
  @spec add_to_cart(struct(), map()) :: %Order{} | {:error, %Ecto.Changeset{}}
  def add_to_cart(%Order{line_items: []} = cart, cart_params) do
    cart
    |> update_cart(%{line_items: [cart_params]})
  end

  def add_to_cart(%Order{line_items: existing_line_items} = cart, cart_params) do
    existing_line_items = Enum.map(existing_line_items, fn items -> Map.from_struct(items) end)

    cart
    |> update_cart(%{line_items: [cart_params | existing_line_items]})
  end
end
