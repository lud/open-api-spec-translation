defmodule LinguoWeb.Schemas do
  defmodule Fake do
    use Gettext, backend: LinguoWeb.Gettext

    def json_schema do
      Gettext.get_locale(LinguoWeb.Gettext)

      %{
        title: gettext("api-spec.fake.title"),
        description: gettext("api-spec.fake.description"),
        type: :object,
        properties: %{
          message: %{
            type: :string,
            description: gettext("api-spec.fake.message-param")
          }
        },
        examples: [
          %{
            "message" => "ok"
          }
        ]
      }
    end
  end

  defmodule FakeResponse do
    use Gettext, backend: LinguoWeb.Gettext

    def json_schema do
      fake_schema = Fake.json_schema()

      %{
        title: gettext("api-spec.fake.response-title"),
        description: gettext("api-spec.fake.response-description"),
        type: :object,
        properties: fake_schema.properties,
        examples: fake_schema.examples
      }
    end
  end

  defmodule ForbiddenResponse do
    use Gettext, backend: LinguoWeb.Gettext

    def json_schema do
      %{
        title: gettext("api-spec.common.forbidden-title"),
        description: gettext("api-spec.common.forbidden-description"),
        type: :object,
        properties: %{title: %{type: :string}, detail: %{type: :string}},
        examples: [%{"title" => "Forbidden", "detail" => "Access denied."}]
      }
    end
  end

  defmodule UnauthorizedResponse do
    use Gettext, backend: LinguoWeb.Gettext

    def json_schema do
      %{
        title: gettext("api-spec.common.unauthorized-title"),
        description: gettext("api-spec.common.unauthorized-description"),
        type: :object,
        properties: %{title: %{type: :string}, detail: %{type: :string}},
        examples: [
          %{
            "title" => "Unauthorized",
            "detail" => "Missing or invalid authorization header."
          }
        ]
      }
    end
  end
end
