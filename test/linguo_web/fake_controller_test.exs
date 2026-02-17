defmodule LinguoWeb.FakeControllerTest do
  use ExUnit.Case, async: true
  import Phoenix.ConnTest
  import Plug.Conn

  @endpoint LinguoWeb.Endpoint

  test "GET /fake with valid token and valid parameter returns ok message" do
    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer some-valid-token")
      |> get("/fake?some-param=valid")

    body = json_response(conn, 200)

    assert body["message"] == "ok"
  end

  test "GET /fake with valid token but invalid parameter returns 400" do
    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer some-valid-token")
      |> get("/fake?some-param=invalid")

    assert json_response(conn, 400)
  end

  test "GET /fake with invalid authorization token returns 401" do
    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer wrong-token")
      |> get("/fake?some-param=valid")

    body = json_response(conn, 401)
    assert body["error"] == "Unauthorized"
  end
end
