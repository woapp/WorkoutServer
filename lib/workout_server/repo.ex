defmodule WorkoutServer.Repo do
  use Ecto.Repo,
    otp_app: :workout_server,
    adapter: Ecto.Adapters.Postgres
end
