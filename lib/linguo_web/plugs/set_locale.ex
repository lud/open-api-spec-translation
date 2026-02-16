defmodule LinguoWeb.Plug.SetLocale do
  @moduledoc false

  @supported_locales Gettext.known_locales(LinguoWeb.Gettext)
  @default_locale Application.compile_env!(:gettext, :default_locale)

  def init(_options), do: nil

  def call(%Plug.Conn{params: %{"locale" => locale}} = conn, _options)
      when locale in @supported_locales do
    Gettext.put_locale(LinguoWeb.Gettext, locale)
    conn
  end

  def call(conn, _options) do
    Gettext.put_locale(LinguoWeb.Gettext, @default_locale)
    conn
  end
end
