defmodule TranslateApi.Router do
  use Plug.Router
  require Logger

  plug Plug.Logger
  plug CORSPlug, origin: ["http://localhost:3000"]

  plug :match
  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  plug :dispatch

  post "/translate" do
    %{
      "text" => text,
      "language" => language
    } = conn.body_params

    source_language = Map.get(conn.body_params, "sourceLanguage")

    IO.inspect({text, language, source_language}, label: "[DEBUG] Params")

    case TranslateApi.OpenAI.translate(text, language) do
      {:ok, %{translated_text: result, detected_source_language: detected}} ->
        IO.inspect(result, label: "[DEBUG] Translated Result")

        TranslateApi.History.save_entry(%{
          text: text,
          language: language,
          source_language: detected || source_language,
          result: result
        })

        send_resp(conn, 200, Jason.encode!(%{
          translated_text: result,
          detected_source_language: detected
        }))

      {:error, reason} ->
        IO.inspect(reason, label: "[DEBUG] Error from OpenAI")
        send_resp(conn, 500, Jason.encode!(%{error: reason}))
    end
  end


  get "/history" do
    history = TranslateApi.History.read_all_entries()
    send_resp(conn, 200, Jason.encode!(%{history: history}))
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end

end