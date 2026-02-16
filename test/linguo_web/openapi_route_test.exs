defmodule LinguoWeb.OpenApiRouteTest do
  use ExUnit.Case, async: true
  import Phoenix.ConnTest

  @endpoint LinguoWeb.Endpoint

  test "GET /openapi renders the spec in the default locale" do
    conn = get(build_conn(), "/openapi")
    body = json_response(conn, 200)

    assert body["info"]["title"] == "API Title"
    assert body["info"]["description"] == "API Description"
    assert body["paths"]["/fake"]["get"]["summary"] == "Fake API GET"
  end

  test "GET /en/openapi renders the english spec" do
    conn = get(build_conn(), "/en/openapi")
    body = json_response(conn, 200)

    assert body["info"]["title"] == "API Title"
    assert body["paths"]["/fake"]["get"]["summary"] == "Fake API GET"
  end

  test "GET /ja/openapi renders the japanese spec" do
    conn = get(build_conn(), "/ja/openapi")
    body = json_response(conn, 200)

    assert body["info"]["title"] == "APIのタイトル"
    assert body["info"]["description"] == "APIの説明"
    assert body["paths"]["/fake"]["get"]["summary"] == "フェイクAPIのGET"
  end
end
