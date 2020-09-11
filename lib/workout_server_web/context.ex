defmodule WorkoutServerWeb.Context do
  @behaviour Plug

  import Plug.Conn
  alias WorkoutServerWeb.Guardian
  alias WorkoutServer.Users.Account
  import Ecto.Query, only: [where: 2]
  alias WorkoutServer.Repo

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})

      _ ->
        conn
    end
  end

  defp build_context(conn) do
    with ["Bearer " <> jwt] <- get_req_header(conn, "authorization"),
         {:ok, current_user} <- authorize(jwt) do
      {:ok, %{current_user: current_user, jwt: jwt}}
    end
  end

  defp authorize(jwt) do
    Account
    |> where(jwt: ^jwt)
    |> Repo.one()
    |> case do
      nil -> {:error, "Invalid authorization jwt"}
      account -> {:ok, account}
    end
  end
end
