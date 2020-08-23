defmodule WorkoutServerWeb.Router do
  use WorkoutServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: WorkoutServerWeb.Schema,
      interface: :simple,
      context: %{pubsub: WorkoutServerWeb.Endpoint}
  end

end