# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :betterfarm,
  ecto_repos: [Betterfarm.Repo]

# Configures the endpoint
config :betterfarm, BetterfarmWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nIwdT/Wwgt0kYdao0t9YK6bbzZ6+ABg8qz2X8W6ISDQc0QeR2kKGyTc2whfmu7Ur",
  render_errors: [view: BetterfarmWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Betterfarm.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# arc configuration
config :arc,
  storage: Arc.Storage.Local

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
