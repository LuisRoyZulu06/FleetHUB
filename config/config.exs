# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :fleet,
  ecto_repos: [Fleet.Repo]

# Configures the endpoint
config :fleet, FleetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fZY6ltoGf5QNBglVIB8GyGo+nsAfU+f5rd8ieChXEkg095dLshoODcsSPve9dUxc",
  render_errors: [view: FleetWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Fleet.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
