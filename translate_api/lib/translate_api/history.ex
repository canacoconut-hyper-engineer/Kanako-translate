defmodule TranslateApi.History do
  @app :translate_api

  defp file_path do
    Application.get_env(@app, :history_file_path, "data/history.json")
  end

  # 翻訳履歴を保存
  def save_entry(%{text: text, language: language, source_language: source_language, result: result}) do
    entry = %{
        timestamp: DateTime.utc_now() |> DateTime.to_iso8601(),
        text: text,
        language: language,
        source_language: source_language,
        result: result
    }


    history = read_all_entries()
    new_data = [entry | history]

    new_data
    |> Jason.encode!(pretty: true)
    |> write_file()

    :ok
  end

  # 翻訳履歴を取得（リスト形式）
  def read_all_entries do
    case File.read(file_path()) do
      {:ok, content} when content != "" ->
        Jason.decode!(content)

      {:ok, _} ->
        []  # 空文字などの場合

      {:error, _} ->
        []  # ファイルがない or その他のエラー
    end
  end

  def get_all do
    read_all_entries()
  end

  def write_file(content) do
    File.mkdir_p!(Path.dirname(file_path()))
    File.write!(file_path(), content)
  end
end
