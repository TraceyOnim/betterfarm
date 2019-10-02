defmodule Betterfarm.Repo do
  use Ecto.Repo,
    otp_app: :betterfarm,
    adapter: Ecto.Adapters.Postgres
end
