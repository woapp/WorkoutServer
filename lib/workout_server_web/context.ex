defmodule WorkoutServerWeb.Context do
  @behaviour Plug

  import Plug.Conn
  alias WorkoutServerWeb.Guardian

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
         {:ok, current_user} <- Guardian.decode_and_verify(jwt) do
      {:ok, %{current_user: current_user, jwt: jwt}}
    end
  end
end
