# Authentication flow

Auth based on this tutorial itnext.io/authenticating-absinthe-graphql-apis-in-phoenix-with-guardian-d647ea45a69a

## Flow

How it works:

- when creating a user, it hashes the password with bcrypt and saves it in db
- when logging in, it checks the password hash, generate and store a jwt in db and returns it to the client
- when doing an authenticated query (done via context), it checks the jwt
- when logging out, it deletes the jwt from the db

## How to require authentication for a mutation / query

In the resolver (ex: [news-resolver](../lib/workout_server_web/resolvers/news_resolver.ex)) add the context as third parameter. Then do the same function without context that will return `{:error, "Not Authorized"}`

```elixir
  def create_link(_root, args, %{context: %{current_user: _current_user}}) do
    case News.create_link(args) do
      {:ok, link} -> {:ok, link}
      _error -> {:error, "could not create link"}
    end
  end

  def create_link(_root, _args, _info) do
    {:error, "Not Authorized"}
  end
```
