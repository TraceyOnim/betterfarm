defmodule Betterfarm.Account do
  @moduledoc """
  Defines all operation performed on farmer ,i.e creating farmer ,updating farmer
  """
  import Ecto.Query
  alias Betterfarm.Farmer
  alias Betterfarm.Repo

  @doc """
  Invokes changeset/2 from Betterfarm.Returns a changeset
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
  same as create_user/1, except that register_farmer/1 register farmer with their email and password credentials.
  Returns {:ok, %Farmer{}} if farmer is created successfully or {:error, changeset} incase of constriant violation or error raised
  """
  @spec register_farmer(map()) :: {:ok, %Farmer{}} | {:error, %Ecto.Changeset{}}
  def register_farmer(attrs) do
    %Farmer{}
    |> Farmer.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  update_farmer/2 updates the existing farmer in the db, whose id is given.
  Returns {:ok, farmer} if the farmer is updated successfully otherwise {:error, changeset}
  """
  @spec update_farmer(integer(), map()) :: {:ok, %Farmer{}} | {:error, %Ecto.Changeset{}}
  def update_farmer(farmer, attrs) do
    farmer
    |> Farmer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  fetches all farmers from the database
  """
  @spec list_farmers() :: [%Farmer{}, ...]
  def list_farmers do
    Farmer
    |> Repo.all()
  end

  @doc """
  get_farmer/1 fetches the farmer from database whose id matches the given id
  Returns %Farmer {} if the farmer exists otherwise nil
  """
  @spec get_farmer(integer()) :: %Farmer{} | nil
  def get_farmer(id) do
    Farmer
    |> Repo.get(id)
  end

  @doc """
  Deletes the farmer whose id given matches.
  Returns {:ok, %Farmer{}} if the farmer is successfully deleted. Otherwise {:error, changeset}

  """
  @spec delete_farmer(integer()) :: {:ok, %Farmer{}} | {:error, %Ecto.Changeset{}}
  def delete_farmer(farmer) do
    farmer
    |> Repo.delete()
  end

  @doc """
  preloaded_farmer_credentials/1 returns farmer's struct with preloaded credentials
  """
  @spec preload_farmer_credential(integer()) :: %Farmer{}
  def preload_farmer_credential(id) do
    farmer = get_farmer(id)
    Repo.preload(farmer, :credential)
  end

  @doc """
  get_farmer_by_email/1 will fetch the farmer whose email address will match the given email.
  Returns %Farmer{} if the farmer exists otherwise nil 
  """
  @spec get_farmer_by_email(String.t()) :: %Farmer{} | nil
  def get_farmer_by_email(email) do
    query = from f in Farmer, join: c in assoc(f, :credential), where: c.email == ^email

    query
    |> Repo.one()
    |> Repo.preload(:credential)
  end

  @doc """
  validates if the user matches the given password. 
  Returns :
  - {:ok, user} if the user is found and password matches
  - {:error, :unauthorized} if the user password doesn't match
  - {:error, :not_found} if the user is not found 
  """
  @spec verify_user_email_and_password(String.t(), String.t()) ::
          {:ok, %Farmer{}} | {:error, :unauthorized} | {:error, :not_found}
  def verify_user_email_and_password(email, password) do
    user = get_farmer_by_email(email)

    cond do
      user && Comeonin.Pbkdf2.checkpw(password, user.credential.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Comeonin.Bcrypt.dummy_checkpw()
        {:error, :not_found}
    end
  end
end
