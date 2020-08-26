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
config :blog_app_gql, BlogAppGql.Guardian,
  # optional
  allowed_algos: ["HS512"],
  # optional
  verify_module: Guardian.JWT,
  issuer: "BlogAppGql",
  ttl: {30, :days},
  allowed_drift: 2000,
  # optional
  verify_issuer: true,
  # generated using: JOSE.JWK.generate_key({:oct, 16}) |> JOSE.JWK.to_map |> elem(1)
  # TODO: generate proper secret key
  secret_key: %{"k" => "3gx0vXjUD2BJ8xfo_aQWIA", "kty" => "oct"},
  serializer: BlogAppGql.Guardian

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
