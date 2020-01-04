defmodule ShopkeeperChallenge do
  def call_me(change) do
    return_change(change, "")
  end

  def return_change(1, acc) do
    acc
  end

  def return_change(change, acc) do
    {string, remaining} = change_amount(change)
    return_change(remaining, acc <> string)
  end

  def change_amount(change) do
    ## amount in denominations

    change =
      case change do
        change > 1000 ->
          {"#{change / 1000} 1000 Notes", Integer.mod(change, 1000)}

        change in 500..1000 ->
          {"#{change / 500} 500 Notes", Integer.mod(change, 500)}

        change in 100..500 ->
          {"#{change / 100} 100 Notes", Integer.mod(change, 100)}

        change in 50..100 ->
          {"#{change / 50} 50 Notes", Integer.mod(change, 50)}

        change in 20..50 ->
          {"#{change / 20} 20 Coins", Integer.mod(change, 20)}

        change in 10..20 ->
          {"#{change / 10} 10 Coins", Integer.mod(change, 10)}

        change in 5..10 ->
          {"#{change / 5} 5 Coins", Integer.mod(change, 5)}

        change in 1..5 ->
          {"#{change / 1} 1 Coin", Integer.mod(change, 1)}
      end
  end
end
