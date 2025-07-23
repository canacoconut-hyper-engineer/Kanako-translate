defmodule TranslateApi.OpenAI do
  @moduledoc false

  def translate(text, language) do
    prompt = """
    You are a translator. Identify the source language of the text and translate it into #{language}.
    Respond ONLY in this JSON format: {"translated_text": "...", "detected_source_language": "..."}
    Text: #{text}
    """

    body = %{
      model: "gpt-3.5-turbo",
      messages: [
        %{role: "system", content: "You are a helpful translator."},
        %{role: "user", content: prompt}
      ]
    }

    headers = [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer #{System.get_env("OPENAI_API_KEY")}"}
    ]

    case Req.post("https://api.openai.com/v1/chat/completions", json: body, headers: headers) do
      {:ok, %{status: 200, body: %{"choices" => [%{"message" => %{"content" => content}}]}}} ->
        IO.inspect(content, label: "[DEBUG] GPT Response Content")

        case Jason.decode(content) do
          {:ok, %{"translated_text" => translated, "detected_source_language" => detected}} ->
            {:ok, %{translated_text: translated, detected_source_language: detected}}

          _ ->
            {:error, "Failed to decode GPT JSON response: #{content}"}
        end

      error ->
        {:error, inspect(error)}
    end
  end
end
