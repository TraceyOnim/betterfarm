defmodule Betterfarm.ProductAccountTest do
  use Betterfarm.DataCase

  alias Betterfarm.Account
  alias Betterfarm.ProductAccount
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
      assert {:ok, product} = ProductAccount.create_product(valid_attr)
    end

    test "product with invalid attributes is not saved into the database", %{
      invalid_attr: invalid_attr
    } do
      assert {:error, changeset} = ProductAccount.create_product(invalid_attr)

      assert Repo.all(Product) == []
    end
  end
end
