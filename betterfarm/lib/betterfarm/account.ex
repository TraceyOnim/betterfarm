defmodule Betterfarm.Account do
  @moduledoc """
  Defines all operation performed on farmer ,i.e creating farmer ,updating farmer
  """
  alias Betterfarm.Farmer
  alias Betterfarm.Repo

  @doc """
  Invokes changeset() from Betterfarm.Returns a changeset
  """
  @spec change_user() :: %Ecto.Changeset{}
  def change_user() do
    %Farmer{}
    |> Farmer.changeset()
  end

  @doc """
  insert farmer into the database. Returns {:ok, farmer} if farmer is created successfully otherwise {:error, changeset}
  incase of constraint violation or error raised
  """
  @spec create_farmer(map()) :: {:ok, %Farmer{}} | {:error, %Ecto.Changeset{}}
  def create_farmer(attrs) do
    %Farmer{}
    |> Farmer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  fetches all farmers from the database
  """
  @spec list_farmers() :: [%Farmer{}, ...]
  def list_farmers do
    Farmer
    |> Repo.all()
  end
end
