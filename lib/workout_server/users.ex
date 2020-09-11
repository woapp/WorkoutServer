defmodule WorkoutServer.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias WorkoutServer.Repo

  alias WorkoutServer.Users.Account

  @doc """
  Returns the list of account.
  """
  def list_account do
    Repo.all(Account)
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.
  """
  def get_account!(id), do: Repo.get!(Account, id)

  @doc """
  Creates a account.
  """
  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account.
  """
  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a account.
  """
  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.
  """
  def change_account(%Account{} = account, attrs \\ %{}) do
    Account.changeset(account, attrs)
  end

  def store_jwt(%Account{} = account, jwt) do
    account
    |> Account.store_jwt_changeset(%{jwt: jwt})
    |> Repo.update()
  end

  def delete_jwt(%Account{} = account) do
    account
    |> Account.store_jwt_changeset(%{jwt: nil})
    |> Repo.update()
  end
end
