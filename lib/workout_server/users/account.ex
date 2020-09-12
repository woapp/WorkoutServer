defmodule WorkoutServer.Users.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "account" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field(:jwt, :string)

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

  def store_jwt_changeset(account, attrs) do
    account
    |> cast(attrs, [:jwt])
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
