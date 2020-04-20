# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :grocery_store,
  ecto_repos: [GroceryStore.Repo]

# Configures the endpoint
config :grocery_store, GroceryStoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EJ0NpFu567sQwKbExHLoDiIdOMw0kx10MP/2DfdhcIBGcmYMqtq2owXrDiNXjTPU",
  render_errors: [view: GroceryStoreWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GroceryStore.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "hYILuJ4t"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
