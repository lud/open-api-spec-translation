defmodule LinguoWeb.Router do
  use LinguoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug OpenApiSpex.Plug.PutApiSpec, module: LinguoWeb.ApiSpec
  end

  pipeline :openapi do
    plug LinguoWeb.Plug.SetLocale
    plug OpenApiSpex.Plug.PutApiSpec, module: LinguoWeb.ApiSpec
  end

  scope "/", LinguoWeb do
    pipe_through :api

    get "/fake", FakeController, :show
  end

  scope "/" do
    pipe_through :openapi

    get "/openapi", OpenApiSpex.Plug.RenderSpec, []
    get "/:locale/openapi", OpenApiSpex.Plug.RenderSpec, []
  end
end
