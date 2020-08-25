defmodule WorkoutServerWeb.UsersResolver do
  alias WorkoutServer.Users

  def account(_root, _args, _info) do
    {:ok, Users.list_account()}
  end

  def create_account(_root, args, _info) do
    case Users.create_account(args) do
      {:ok, account} -> {:ok, account}
      _error -> {:error, "could not create account"}
    end
  end
end
