defmodule WorkoutServerWeb.Resolvers.User do
  alias WorkoutServer.Users
  alias WorkoutServerWeb.AuthHelper
  alias WorkoutServerWeb.Guardian

  def(account(_root, _args, _info)) do
    {:ok, Users.list_account()}
  end

  def login(%{email: email, password: password}, _info) do
    with {:ok, account} <- AuthHelper.login_with_email_pass(email, password),
         {:ok, jwt, _} <- Guardian.encode_and_sign(account) do
      {:ok, %{jwt: jwt}}
    end
  end

  def create_account(_root, args, _info) do
    case Users.create_account(args) do
      {:ok, account} -> {:ok, account}
      _error -> {:error, "could not create account"}
    end
  end
end
