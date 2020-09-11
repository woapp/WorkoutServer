defmodule WorkoutServerWeb.Resolvers.User do
  alias WorkoutServer.Users
  alias WorkoutServerWeb.AuthHelper
  alias WorkoutServerWeb.Guardian
  alias WorkoutServer.Users

  def account(_root, _args, _info) do
    {:ok, Users.list_account()}
  end

  def login(%{email: email, password: password}, _info) do
    with {:ok, account} <- AuthHelper.login_with_email_pass(email, password),
         {:ok, jwt, _} <- Guardian.encode_and_sign(account),
         {:ok, _} <- Users.store_jwt(account, jwt) do
      {:ok, %{jwt: jwt}}
    end
  end

  def logout(_args, %{context: %{current_user: current_user}}) do
    Users.delete_jwt(current_user)
    {:ok, "logout successful"}
  end

  def logout(_args, _info) do
    {:error, "Please log in first!"}
  end

  def create_account(_root, args, _info) do
    case Users.create_account(args) do
      {:ok, account} -> {:ok, account}
      _error -> {:error, "could not create account"}
    end
  end
end
