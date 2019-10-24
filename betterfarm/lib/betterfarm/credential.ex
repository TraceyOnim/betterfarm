defmodule Betterfarm.Credential do
  use Ecto.Schema
  import Ecto.Changeset

  alias Betterfarm.Farmer

  schema "credentials" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    belongs_to :farmer, Farmer

    timestamps()
  end

  def changeset(credential, attrs \\ %{}) do
    credential
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_length(:password, min: 5, max: 50)
    |> put_pass_hash()
  end

  def put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Pbkdf2.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
