defmodule LinguoWeb.FakeController do
  use LinguoWeb, :controller
  use Oaskit.Controller

  plug Oaskit.Plugs.ValidateRequest, security: LinguoWeb.Plug.FakeSecurity

  alias LinguoWeb.Schemas.FakeResponse
  alias LinguoWeb.Schemas.ForbiddenResponse
  alias LinguoWeb.Schemas.UnauthorizedResponse

  @operation_id "FakeShow"

  def __oaskit__(:operation_id, :show, _) do
    {:ok, @operation_id}
  end

  def __oaskit__(:operation, :show, _) do
    {:ok,
     %Oaskit.Spec.Operation{
       description: gettext("api-spec.fake.show-description"),
       summary: gettext("api-spec.fake.show-summary"),
       operationId: @operation_id,
       parameters: [
         %Oaskit.Spec.Parameter{
           name: "some-param",
           in: :query,
           required: true,
           schema: %{const: "valid"}
         }
       ],
       responses: %{
         200 => %Oaskit.Spec.Response{
           content: %{
             "application/json" => %Oaskit.Spec.MediaType{
               schema: FakeResponse
             }
           },
           description: gettext("api-spec.fake.show-response-ok")
         },
         401 => %Oaskit.Spec.Response{
           content: %{
             "application/json" => %Oaskit.Spec.MediaType{
               schema: UnauthorizedResponse
             }
           },
           description: gettext("api-spec.common.unauthorized")
         },
         403 => %Oaskit.Spec.Response{
           content: %{
             "application/json" => %Oaskit.Spec.MediaType{
               schema: ForbiddenResponse
             }
           },
           description: gettext("api-spec.common.forbidden")
         }
       },
       security: [%{"OAuth2ClientCredentials" => []}],
       tags: ["fake"]
     }}
  end

  def show(conn, _params) do
    render(conn, %{message: "ok"})
  end
end
