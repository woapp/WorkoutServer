defmodule WorkoutServerWeb.AuthHelper do
  @moduledoc false

  # import Comeonin.Bcrypt, only: [checkpw: 2]
  alias WorkoutServer.Repo
  alias WorkoutServer.Users.Account

  def login_with_email_pass(email, given_pass) do
    account = Repo.get_by(Account, email: String.downcase(email))

    cond do
      # TODO: so far, password is not hashed
      # once its done, replace below line with
      #       user && checkpw(given_pass, user.password_hash) ->
      account && given_pass === account.password_hash ->
        {:ok, account}

      account ->
        {:error, "Incorrect login credentials"}

      true ->
        {:error, :"account not found"}
    end
  end
end
