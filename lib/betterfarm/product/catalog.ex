defmodule Betterfarm.Product.Catalog do
  @moduledoc """
   This is product context
  """
  import Ecto.Query
  alias Betterfarm.Category
  alias Betterfarm.Repo
  alias Betterfarm.Product
  alias Betterfarm.ProductName
  alias Betterfarm.Image

  @doc """
  Fetches product_name from database otherwise it will insert the product_name if it doesn't exist.
  Returns %ProductName{}
  """
  @spec create_or_get_product_name(String.t()) :: %ProductName{}
  def create_or_get_product_name(name) do
    Repo.get_by(ProductName, name: name) || Repo.insert!(%ProductName{name: name})
  end

  @doc """
  Fetches category name from database otherwise it will insert the category name if it doesn't exist.
  Returns %Category{}
  """

  @spec create_or_get_category(String.t()) :: %Category{}
  def create_or_get_category(name) do
    Repo.get_by(Category, name: name) || Repo.insert!(%Category{name: name})
  end

  @doc """
  Returns a changeset
  """
  @spec change_product(struct()) :: %Ecto.Changeset{}
  def change_product(%Product{} = product) do
    product
    |> Product.changeset()
  end

  @doc """
  Returns a list of product_name
  """
  def list_product_name do
    query = from p in ProductName, select: {p.name, p.id}

    query
    |> Repo.all()
  end

  @doc """
  Returns list of categories
  """

  def list_category_name do
    query = from c in Category, select: {c.name, c.id}

    query
    |> Repo.all()
  end

  @doc """
  Inserts product into the database.
  Returns {:ok, %Product{}} if saved successfully otherwise {:error, changeset}
  """
  @spec create_product(map()) :: {:ok, %Product{}} | {:error, %Ecto.Changeset{}}
  def create_product(attrs) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def create_image(image, product_id) do
    %Image{}
    |> Image.changeset(%{avatar: image, product_id: product_id, uuid: Ecto.UUID.generate()})
    |> Repo.insert()
  end

  defp copy_to_folder(images, folderpath, product_id) do
    for image <- images do
      image_path = "#{Ecto.UUID.generate()}#{image.filename |> Path.extname()}"

      File.cp!(
        image.path,
        folderpath <> "/#{image_path}"
      )

      image_path |> create_image(product_id)
    end
  end

  def copy_images(images, product_id) do
    folderpath = Application.app_dir(:betterfarm, "priv/uploads")

    case File.exists?(folderpath) do
      true ->
        copy_to_folder(images, folderpath, product_id)

      false ->
        :ok = File.mkdir(folderpath)
        copy_to_folder(images, folderpath, product_id)
    end
  end
end
