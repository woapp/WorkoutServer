defmodule WorkoutServerWeb.Router do
  use WorkoutServerWeb, :router

  pipeline :graphql do
    plug WorkoutServerWeb.Context
  end

  scope "/api" do
    pipe_through(:graphql)

    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: WorkoutServerWeb.Schema.Schema,
      interface: :simple,
      context: %{pubsub: WorkoutServerWeb.Endpoint}
    )

    forward("/", Absinthe.Plug, schema: WorkoutServerWeb.Schema.Schema)
  end
end
