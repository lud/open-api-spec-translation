defmodule LinguoWeb.Gettext do
  @moduledoc """
  Gettext backend for OpenApiSpex translations.
  """

  use Gettext.Backend, otp_app: :linguo
end
