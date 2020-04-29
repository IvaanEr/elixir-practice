# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phinx,
  ecto_repos: [Phinx.Repo]

# Configures the endpoint
config :phinx, PhinxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SpbUfSwz7O55anNP0MVlxnzBU5DV0OLM9QNlDOlaRy9a+bL4VBd9UQNyT0i9u93d",
  render_errors: [view: PhinxWeb.ErrorView, accepts: ~w(json)],
  pubsub_server: Phinx.PubSub,
  live_view: [signing_salt: "MM3PRgkb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phinx, Phinx.Vault,
  ciphers: [
    default: {Cloak.Ciphers.AES.GCM, tag: "AES.GCM.V1", key: Base.decode64!("psAGzHyEMtL3/ZD15IFN72jqEebq6U/D1Hx4YL6Dd0k=")}
  ]
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
