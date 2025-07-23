defmodule TranslateApiTest do
  use ExUnit.Case
  alias TranslateApi.History

  @test_data %{text: "hello", language: "Japanese", result: "こんにちは"}

  setup do
    File.rm_rf!("tmp")
    File.mkdir_p!("tmp")
    Application.put_env(:translate_api, :history_file_path, "tmp/test_history.json")
    :ok
  end

  test "save_entry writes data and read_all_entries returns it" do
    :ok = History.save_entry(@test_data)
    history = History.read_all_entries()

    assert is_list(history)
    assert length(history) > 0

    entry = hd(history)
    assert entry["text"] == "hello"
    assert entry["language"] == "Japanese"
    assert entry["result"] == "こんにちは"
    assert is_binary(entry["timestamp"])
  end
end