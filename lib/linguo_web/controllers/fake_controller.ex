defmodule LinguoWeb.FakeController do
  use LinguoWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias OpenApiSpex.Operation
  alias LinguoWeb.Schemas.FakeResponse
  alias LinguoWeb.Schemas.ForbiddenResponse
  alias LinguoWeb.Schemas.UnauthorizedResponse

  plug OpenApiSpex.Plug.CastAndValidate, render_error: LinguoWeb.Plug.JsonRenderError

  def open_api_operation(action) do
    operation = String.to_existing_atom("#{action}_operation")
    apply(__MODULE__, operation, [])
  end

  def show_operation do
    %Operation{
      tags: ["fake"],
      security: [%{}, %{"OAuth2ClientCredentials" => []}],
      description: gettext("api-spec.fake.show-description"),
      summary: gettext("api-spec.fake.show-summary"),
      operationId: "FakeController.show",
      parameters: [],
      responses: %{
        200 =>
          Operation.response(
            gettext("api-spec.fake.show-response-ok"),
            "application/json",
            FakeResponse
          ),
        401 =>
          Operation.response(
            gettext("api-spec.common.unauthorized"),
            "application/json",
            UnauthorizedResponse
          ),
        403 =>
          Operation.response(
            gettext("api-spec.common.forbidden"),
            "application/json",
            ForbiddenResponse
          )
      },
      extensions: %{
        "x-codeSamples" => [
          %{
            lang: "cURL",
            label: "cURL",
            source: "curl -X GET \"#{app_scheme()}://#{app_host()}/fake\""
          }
        ]
      }
    }
  end

  def show(conn, _params) do
    render(conn, %{message: "ok"})
  end
end
