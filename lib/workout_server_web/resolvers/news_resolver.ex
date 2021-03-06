defmodule WorkoutServerWeb.Resolvers.News do
  alias WorkoutServer.News

  def all_links(_root, _args, _info) do
    {:ok, News.list_links()}
  end

  def create_link(_root, args, %{context: %{current_user: _current_user}}) do
    case News.create_link(args) do
      {:ok, link} -> {:ok, link}
      _error -> {:error, "could not create link"}
    end
  end

  def create_link(_root, _args, _info) do
    {:error, "Not Authorized"}
  end
end
