defmodule WorkoutServerWeb.AuthHelper do
  @moduledoc false

  alias WorkoutServer.Repo
  alias WorkoutServer.Users.Account

  def login_with_email_pass(email, given_password) do
    account = Repo.get_by(Account, email: String.downcase(email))

    cond do
      account && Bcrypt.verify_pass(given_password, account.password_hash) ->
        {:ok, account}

      account ->
        {:error, "Incorrect login credentials"}

      true ->
        {:error, :"account not found"}
    end
  end
end
