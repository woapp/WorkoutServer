defmodule WorkoutServer.UsersTest do
  use WorkoutServer.DataCase

  alias WorkoutServer.Users

  describe "account" do
    alias WorkoutServer.Users.Account

    @valid_attrs %{email: "some email", name: "some name", password_hash: "some password_hash"}
    @update_attrs %{email: "some updated email", name: "some updated name", password_hash: "some updated password_hash"}
    @invalid_attrs %{email: nil, name: nil, password_hash: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_account()

      account
    end

    test "list_account/0 returns all account" do
      account = account_fixture()
      assert Users.list_account() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Users.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = Users.create_account(@valid_attrs)
      assert account.email == "some email"
      assert account.name == "some name"
      assert account.password_hash == "some password_hash"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, %Account{} = account} = Users.update_account(account, @update_attrs)
      assert account.email == "some updated email"
      assert account.name == "some updated name"
      assert account.password_hash == "some updated password_hash"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_account(account, @invalid_attrs)
      assert account == Users.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Users.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Users.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Users.change_account(account)
    end
  end
end
