defmodule TranslateApi.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias TranslateApi.Router

  @opts Router.init([])

  test "POST /translate with valid data returns 200 and translated_text" do
    conn =
      conn(:post, "/translate", Jason.encode!(%{"text" => "Hello", "language" => "ja"}))
      |> put_req_header("content-type", "application/json")
      |> Router.call(@opts)

    assert conn.status == 200
    response = Jason.decode!(conn.resp_body)
    assert Map.has_key?(response, "translated_text")
  end

  test "POST /translate with missing params returns 500" do
    conn =
      conn(:post, "/translate", Jason.encode!(%{}))
      |> put_req_header("content-type", "application/json")
      |> Router.call(@opts)

    assert conn.status == 500
  end

  test "GET /unknown returns 404" do
    conn = conn(:get, "/unknown") |> Router.call(@opts)
    assert conn.status == 404
    assert conn.resp_body == "Not found"
  end
end
