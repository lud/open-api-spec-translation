defmodule LinguoWeb.ErrorJSON do
  @moduledoc """
  This module is invoked by your endpoint in case of errors on JSON requests.

  See config/config.exs.
  """

  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".

  def render("401.json", _assigns) do
    %{title: "Unauthorized", detail: "Missing or invalid authorization header."}
  end

  def render("403.json", %{error_detail: error_detail}) do
    %{title: "Forbidden", detail: error_detail}
  end

  def render("403.json", _assigns) do
    %{title: "Forbidden", detail: "Access denied."}
  end

  def render("429.json", _assigns) do
    %{title: "Too many requests", detail: "Rate limit exceeded."}
  end

  def render("404.json", _assigns) do
    %{title: "Not found", detail: "Entity not found."}
  end

  def render("error.json", %{errors: errors}) do
    %{
      title: "Invalid request",
      detail: "One or more of the request parameters is invalid",
      errors: errors
    }
  end

  def render("error.json", %{error: error}) do
    %{title: "Invalid request", detail: error}
  end

  def render(template, _assigns) do
    %{
      title: "Invalid request",
      detail: Phoenix.Controller.status_message_from_template(template)
    }
  end
end
