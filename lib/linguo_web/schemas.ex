defmodule LinguoWeb.Schemas do
  alias OpenApiSpex.Schema

  defmodule Fake do
    @behaviour OpenApiSpex.Schema
    use Gettext, backend: LinguoWeb.Gettext


    def schema do
      %OpenApiSpex.Schema{
        title: gettext("api-spec.fake.title"),
        description: gettext("api-spec.fake.description"),
        type: :object,
        properties: %{
          message: %Schema{
            type: :string,
            description: gettext("api-spec.fake.message-param")
          },
        },
        example: %{
          "message" => "ok"
        }
      }
    end
  end

  defmodule FakeResponse do
        @behaviour OpenApiSpex.Schema
    use Gettext, backend: LinguoWeb.Gettext

    def schema do
      %OpenApiSpex.Schema{
        title: gettext("api-spec.fake.response-title"),
        description: gettext("api-spec.fake.response-description"),
        type: :object,
        properties: Fake.schema().properties,
        example: Fake.schema().example
      }
    end
  end

  defmodule ForbiddenResponse do
    @behaviour OpenApiSpex.Schema
    use Gettext, backend: LinguoWeb.Gettext

    def schema do
      %OpenApiSpex.Schema{
        title: gettext("api-spec.common.forbidden-title"),
        description: gettext("api-spec.common.forbidden-description"),
        type: :object,
        properties: %{title: %Schema{type: :string}, detail: %Schema{type: :string}},
        example: %{"title" => "Forbidden", "detail" => "Access denied."}
      }
    end
  end

  defmodule UnauthorizedResponse do
    @behaviour OpenApiSpex.Schema
    use Gettext, backend: LinguoWeb.Gettext

    def schema do
      %OpenApiSpex.Schema{
        title: gettext("api-spec.common.unauthorized-title"),
        description: gettext("api-spec.common.unauthorized-description"),
        type: :object,
        properties: %{title: %Schema{type: :string}, detail: %Schema{type: :string}},
        example: %{
          "title" => "Unauthorized",
          "detail" => "Missing or invalid authorization header."
        }
      }
    end
  end
end
