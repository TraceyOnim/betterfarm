defmodule BetterfarmWeb.ProductTest do
  use BetterfarmWeb.IntegrationCase

  alias Betterfarm.Account

  setup do
    farmer_attr = %{
      first_name: "first",
      last_name: "last",
      phone_number: "0718039045",
      national_id: "1234567",
      country: "Kenya",
      county: "Kisumu",
      gender: "female",
      credential: %{email: "firstlast@email.com", password: "secret"}
    }

    {:ok, farmer} = Account.register_farmer(farmer_attr)
    [farmer: farmer]
  end

  describe "ADDING PRODUCT" do
    test "user can see product link when logged in", %{conn: conn, farmer: farmer} do
      conn
      |> _sign_in_user(farmer)
      |> assert_response(html: "Product")
    end

    test "user can add product", %{conn: conn, farmer: farmer} do
      conn
      |> _sign_in_user(farmer)
      |> get(Routes.farmer_product_path(conn, :new, farmer.id))
      |> follow_form(%{
        product: %{
          name: "sukuma",
          price: 1000.00,
          location: "kisumu",
          description: "fresh sweet sukuma",
          quantity: 100,
          category: "veges",
          unit: "kg",
          image: []
        }
      })
      |> assert_response(html: "product added successfully")
    end

    test "product is not added with invalid data provided", %{conn: conn, farmer: farmer} do
      conn
      |> _sign_in_user(farmer)
      |> get(Routes.farmer_product_path(conn, :new, farmer.id))
      |> follow_form(%{product: %{}})
      |> assert_response(html: "Something went wrong, Try Again")
    end

    test "denies adding of product if user is not logged in", %{conn: conn, farmer: farmer} do
      conn
      |> follow_path(Routes.farmer_product_path(conn, :new, farmer.id))
      |> assert_response(html: "You must be logged in to access that page")
    end
  end

  defp _sign_in_user(conn, user) do
    conn
    |> get(Routes.session_path(conn, :new))
    |> follow_form(%{session: %{email: user.credential.email, password: "secret"}})
  end
end
