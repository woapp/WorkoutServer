defmodule WorkoutServer.Users.Account do
  use Ecto.Schema
  import Ecto.Changeset
  # alias Bcrypt
  alias Comeonin

  schema "account" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_length(:name, min: 2, max: 15)
    |> validate_length(:password, min: 4, max: 20)
    |> unique_constraint(:email, downcase: true)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass, []))

      _ ->
        changeset
    end
  end
end
