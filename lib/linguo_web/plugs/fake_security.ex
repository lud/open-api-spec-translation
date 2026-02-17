defmodule LinguoWeb.Plug.FakeSecurity do
  @moduledoc """
  Fake security plug for demonstration purposes.
  Checks for a bearer token in the Authorization header.
  """
  require Logger
  import Plug.Conn

  @behaviour Plug

  @impl Plug
  def init(opts), do: opts

  @impl Plug
  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer some-valid-token"] ->
        Logger.warning("Fake security: authorized request with valid token")
        conn

      _ ->
        Logger.warning("Fake security: unauthorized - invalid or missing token")

        conn
        |> put_status(401)
        |> Phoenix.Controller.json(%{
          error: "Unauthorized",
          detail: "Invalid or missing authorization token"
        })
        |> halt()
    end
  end
end
