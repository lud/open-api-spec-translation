defmodule LinguoWeb do
  alias LinguoWeb.Endpoint

  def static_paths, do: ~w(assets fonts images favicon.ico robots.txt)

  def router do
    quote do
      use Phoenix.Router, helpers: true

      # Import common connection and controller functions to use in pipelines
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  def controller do
    quote do
      use Phoenix.Controller,
        formats: [:html, :json],
        layouts: [html: LinguoWeb.Layouts]

      use Gettext, backend: LinguoWeb.Gettext

      import Plug.Conn

      unquote(verified_routes())
    end
  end

  def json do
    quote do
      use Gettext, backend: LinguoWeb.Gettext

      import Plug.Conn

      unquote(verified_routes())
    end
  end

  def verified_routes do
    quote do
      use Phoenix.VerifiedRoutes,
        endpoint: Endpoint,
        router: LinguoWeb.Router,
        statics: LinguoWeb.static_paths()

      unquote(endpoint_helpers())
    end
  end

  def endpoint_helpers do
    quote do
      def app_host do
        host = Endpoint.config(:url)[:host]

        if host === "localhost" do
          port = Endpoint.config(:http)[:port]

          "#{host}:#{port}"
        else
          host
        end
      end

      def app_scheme do
        Endpoint.config(:url)[:scheme]
      end
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/live_view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
