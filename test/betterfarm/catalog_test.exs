defmodule Betterfarm.CatalogTest do
  use Betterfarm.DataCase
  import Betterfarm.Factory

  alias Betterfarm.Account
  alias Betterfarm.Product.Catalog
  alias Betterfarm.Product
  alias Betterfarm.Repo

  setup do
    valid_attr = %{
      first_name: "second",
      last_name: "last",
      phone_number: "0718039047",
      nationality: "1234563",
      country: "Kenya",
      county: "Kisumu",
      gender: "male",
      credential: %{email: "secondlast@email.com", password: "secret0"}
    }

    {:ok, farmer} = Account.register_farmer(valid_attr)

    valid_attr = %{
      "name" => "sukuma",
      "price" => 1000,
      "location" => "nyakach",
      "description" => "fresh sukuma",
      "pack_size" => 10,
      "unit" => "kg",
      "category" => "vegetables",
      "farmer_id" => farmer.id
    }

    invalid_attr = %{}

    [valid_attr: valid_attr, farmer: farmer, invalid_attr: invalid_attr]
  end

  describe "create_product/1" do
    test "product is saved into the database", %{valid_attr: valid_attr} do
      assert {:ok, product} = Catalog.create_product(valid_attr)
    end

    test "product with invalid attributes is not saved into the database", %{
      invalid_attr: invalid_attr
    } do
      assert {:error, changeset} = Catalog.create_product(invalid_attr)

      assert Repo.all(Product) == []
    end
  end

  test "list_product/0 returns all products" do
    # insert first product
    {:ok, first_product} = insert!(:product)
    # insert second product
    {:ok, second_product} = insert!(:product)

    assert [first_product, second_product] = Catalog.list_product()
    assert Catalog.list_product() |> Enum.count() == 2
  end

  test "get_product_name/1 returns product name of the given id" do
    # insert product_name
    {:ok, product_name} = insert!(:product_name)
    # insert product
    {:ok, product} = insert!(:product, name: "#{product_name.id}")
    name = product.name |> Catalog.get_product_name()
    assert name == product_name.name
  end
end
