defmodule LinguoWeb.Router do
  use LinguoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Oaskit.Plugs.SpecProvider, spec: LinguoWeb.ApiSpec
  end

  pipeline :openapi do
    plug LinguoWeb.Plug.SetLocale
  end

  scope "/", LinguoWeb do
    pipe_through :api

    get "/fake", FakeController, :show
  end

  scope "/" do
    pipe_through :openapi

    get "/openapi", Oaskit.SpecController, spec: LinguoWeb.ApiSpec
    get "/:locale/openapi", Oaskit.SpecController, spec: LinguoWeb.ApiSpec
  end
end
