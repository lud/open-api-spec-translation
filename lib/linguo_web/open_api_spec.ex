defmodule LinguoWeb.ApiSpec do
  use Oaskit
  use LinguoWeb, :verified_routes
  use Gettext, backend: LinguoWeb.Gettext

  alias Oaskit.Spec.Paths
  alias Oaskit.Spec.Server

  @impl true
  def cache_variant do
    # Note
    #
    # This is not needed if you only want translations when serving the spec as
    # JSON.
    #
    # But if your schemas have properties or titles that change according to the
    # locale, then you want to build and cache a spec for each locale. So you
    # can define a cache variant for each version of the spec:

    Gettext.get_locale(LinguoWeb.Gettext)
  end

  @impl true
  def spec do
    %{
      openapi: "3.1.0",
      info: %{
        title: gettext("linguo.api.info.title"),
        version: "1.0.0",
        description: gettext("linguo.api.info.description")
      },
      servers: [Server.from_config(:linguo, LinguoWeb.Endpoint)],
      paths: Paths.from_router(LinguoWeb.Router),
      components: %{
        securitySchemes: %{
          "OAuth2ClientCredentials" => %{
            type: "oauth2",
            description: "OAuth2",
            flows: %{
              clientCredentials: %{
                tokenUrl: "/oauth/token",
                scopes: %{}
              }
            }
          }
        }
      }
    }
  end
end
