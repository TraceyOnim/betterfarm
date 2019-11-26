defmodule Betterfarm.AccountTest do
  use Betterfarm.DataCase

  alias Betterfarm.Account
  alias Betterfarm.Repo
  alias Betterfarm.Farmer

  setup do
    valid_attr = %{
      first_name: "first",
      last_name: "last",
      phone_number: "0718039045",
      nationality: "1234567",
      country: "Kenya",
      county: "Kisumu",
      gender: "female",
      credential: %{email: "firstlast@email.com", password: "secret"}
    }

    valid_attr2 = %{
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

    invalid_attr = %{}

    [valid_attr: valid_attr, invalid_attr: invalid_attr, valid_attr2: valid_attr2, farmer: farmer]
  end

  describe "creating farmers" do
    test "farmer is registered with valid data", %{valid_attr: valid_attr} do
      assert {:ok, farmer} = Account.register_farmer(valid_attr)
      %Farmer{first_name: first_name} = Repo.get(Farmer, farmer.id)
      assert first_name == "first"
    end

    test "with invalid data doesn't insert user", %{invalid_attr: invalid_attr} do
      assert {:error, _changeset} = Account.register_farmer(invalid_attr)
    end
  end

  describe "verify_user_email_and_password/2" do
    @email "firstlast@email.com"
    @pass "secret"

    test "returns farmer with correct password", %{farmer: %Farmer{id: id}} do
      {:ok, farmer} = Account.verify_user_email_and_password(@email, @pass)
      assert farmer.id == id
    end

    test "returns unauthorized error with invalid password" do
      assert {:error, :unauthorized} = Account.verify_user_email_and_password(@email, "123")
    end

    test "returns not_found error if user is not found" do
      assert {:error, :not_found} =
               Account.verify_user_email_and_password("first@email.com", @pass)
    end
  end

  test "list_farmers/0  fetches all farmers from the database", %{
    valid_attr2: valid_attr2
  } do
    {:ok, _farmer2} = Account.register_farmer(valid_attr2)
    assert Farmer |> Repo.all() |> Enum.count() == 2
  end

  describe "get_farmer/1" do
    test "fetches farmer from database whose id matches the given id", %{farmer: farmer} do
      %Farmer{first_name: first_name} = Account.get_farmer(farmer.id)
      assert first_name == farmer.first_name
    end

    test "returns nil if farmer doesn't exist" do
      assert Account.get_farmer(1) == nil
    end
  end

  describe "get_farmer_by_email/1" do
    test "fetches farmer from database whose email matches the given email", %{farmer: farmer} do
      %Farmer{first_name: first_name} = Account.get_farmer_by_email(farmer.credential.email)
      assert first_name == farmer.first_name
    end

    test "returns nil if farmer doesn't exist" do
      assert Account.get_farmer_by_email("first@email.com") == nil
    end
  end
end
