# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Betterfarm.Repo.insert!(%Betterfarm.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Betterfarm.ProductAccount

for name <-
      ~w(wheat corn sorghum cowpea greengrams beans millet maize rice banana apple mango pineapple orange avacado pear egg milk spinach cabbage pumpkin eggplant pepper cucumber cauliflower mushrooms carrots tomatoes onions kienyeji garlic lettuce potato yam zucchini cattle sheep chicken goat pig rabbit duck cattle calf donkey) do
  ProductAccount.create_or_get_product_name(name)
end

for category <- ~w(cereals fruits dairy_products farm_animals vegetables) do
  ProductAccount.create_or_get_category(category)
end
