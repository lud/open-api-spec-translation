defmodule LinguoWeb.FallbackController do
  use LinguoWeb, :controller

  alias LinguoWeb.ErrorJSON

  def call(conn, {:error, message}) when is_binary(message) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorJSON)
    |> render("error.json", %{error: message})
  end

  def call(conn, {:error, errors}) when is_list(errors) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorJSON)
    |> render("error.json", %{errors: errors})
  end

  def call(conn, nil) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorJSON)
    |> render("404.json")
  end
end
