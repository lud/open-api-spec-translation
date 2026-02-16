defmodule LinguoWeb.ApiSpec do
  @behaviour OpenApiSpex.OpenApi
  use LinguoWeb, :verified_routes
  use Gettext, backend: LinguoWeb.Gettext

  alias OpenApiSpex.Info
  alias OpenApiSpex.OpenApi
  alias OpenApiSpex.Paths
  alias OpenApiSpex.Components
  alias OpenApiSpex.SecurityScheme
  alias OpenApiSpex.Server

  def info do
    %Info{
      title: gettext("linguo.api.info.title"),
      version: "1.0.0",
      description: gettext("linguo.api.info.description")
    }
  end

  def components do
    %Components{
      securitySchemes: %{
        "OAuth2ClientCredentials" => %SecurityScheme{
          type: "oauth2",
          description: "OAuth2",
          flows: %{
            "clientCredentials" => %{
              tokenUrl: "/oauth/token",
              scopes: %{

              }
            }
          }
        }
      }
    }
  end

  @impl OpenApi
  def spec do
    %OpenApi{
      servers: [%Server{url: "#{app_scheme()}://#{app_host()}"}],
      info: info(),
      paths: Paths.from_router(LinguoWeb.Router),
      components: components()
    }
    # Discover request/response schemas from path specs
    |> OpenApiSpex.resolve_schema_modules()
  end
end
