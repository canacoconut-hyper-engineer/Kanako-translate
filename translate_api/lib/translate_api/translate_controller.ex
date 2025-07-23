defmodule TranslateApi.TranslateController do
  import Plug.Conn
  alias TranslateApi.History
  alias TranslateApi.OpenAI

  def init(options), do: options

  def call(%Plug.Conn{method: "POST", request_path: "/translate"} = conn, _opts) do
    {:ok, body, _conn} = Plug.Conn.read_body(conn)
    params = Jason.decode!(body)

    %{
      "text" => text,
      "language" => language,
      "sourceLanguage" => source_language
    } = params

    translated_text = OpenAI.translate(text, language)

    History.save_entry(%{
      text: text,
      language: language,
      source_language: source_language,
      result: translated_text
    })

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{result: translated_text}))
  end

  def call(conn, _opts) do
    send_resp(conn, 404, "Not found")
  end
end