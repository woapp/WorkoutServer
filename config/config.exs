# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :workout_server,
  ecto_repos: [WorkoutServer.Repo]

# Configures the endpoint
config :workout_server, WorkoutServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DtjkXiovzL893OXAUNDaFfhPwDVmlxl5wwRYZljSEgmL5g6kG0fR0NNVQsL581yN",
  render_errors: [view: WorkoutServerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: WorkoutServer.PubSub,
  live_view: [signing_salt: "UwZYVXUq"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# configures Guardian
config :workout_server_web, WorkoutServerWeb.Guardian,
  issuer: "workout_server_web",
  secret_key: "QNwOcSVDJKJAitQX6/LFDGO71oYu8koOoicVIqdx2zeQnlgCDLZQo2Tc86n/Nody"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
