import Config

config :gettext, locales: ~w(en ja), default_locale: "en"

config :phoenix, :json_library, Jason

config :linguo, LinguoWeb.Endpoint,
  url: [host: "localhost", scheme: "http", port: 4000],
  http: [ip: {127, 0, 0, 1}, port: 4000],
  server: true,
  render_errors: [
    formats: [json: LinguoWeb.ErrorJSON],
    layout: false
  ]
