ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Betterfarm.Repo, :manual)

defmodule Betterfarm.TestHelpers do
  alias Betterfarm.Account

  def farmer_fixture do
    valid_attributes = %{
      first_name: "first",
      last_name: "last",
      phone_number: "0718039045",
      nationality: "1234567",
      country: "Kenya",
      county: "Kisumu",
      gender: "female",
      credential: %{email: "firstlast@email.com", password: "secret"}
    }

    {:ok, farmer} = Account.register_farmer(valid_attributes)
    farmer
  end
end
