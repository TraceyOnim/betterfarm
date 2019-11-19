defmodule Betterfarm.ProductAccountTest do
  use Betterfarm.DataCase

  alias Betterfarm.Product.Account
  alias Betterfarm.Product
  alias Betterfarm.Repo

  setup do
    farmer = farmer_fixture()

    valid_attr = %{
      "name" => "sukuma",
      "price" => 1000,
      "location" => "nyakach",
      "description" => "fresh sukuma",
      "quantity" => "10",
      "unit" => "kg",
      "category" => "vegetables",
      "farmer_id" => farmer.id
    }

    invalid_attr = %{}

    [valid_attr: valid_attr, farmer: farmer, invalid_attr: invalid_attr]
  end

  describe "create_product/1" do
    test "product is saved into the database", %{valid_attr: valid_attr} do
      {:ok, product} = Account.create_product(valid_attr)
      assert product.name == "sukuma"
    end

    test "product with invalid attributes is not saved into the database", %{
      invalid_attr: invalid_attr
    } do
      assert {:error, changeset} = Account.create_product(invalid_attr)
      assert Repo.all(Product) == []
    end
  end
end
