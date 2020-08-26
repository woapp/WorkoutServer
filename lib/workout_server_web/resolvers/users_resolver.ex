defmodule WorkoutServerWeb.UsersResolver do
  alias WorkoutServer.Users
  alias WorkoutServerWeb.AuthHelper
  import WorkoutServerWeb.AuthHelper

  def account(_root, _args, _info) do
    {:ok, Users.list_account()}
  end

  def login(%{email: email, password: password}, _info) do
    with do
      {:ok, user} <- AuthHelper.login_with_email_pass(email, password)
      #  {:ok, jwt, _} <- BlogAppGql.Guardian.encode_and_sign(user),
      {:ok, %{token: jwt}}
    end
  end

  def create_account(_root, args, _info) do
    case Users.create_account(args) do
      {:ok, account} -> {:ok, account}
      _error -> {:error, "could not create account"}
    end
  end
end
