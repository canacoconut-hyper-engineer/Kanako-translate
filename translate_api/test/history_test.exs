defmodule TranslateApi.HistoryTest do
  use ExUnit.Case
  alias TranslateApi.History

  @sample_entry %{
    "text" => "こんにちは",
    "result" => "Hello",
    "language" => "English",
    "timestamp" => "2025-07-22T12:00:00Z"
  }

  test "save_entry/1 and get_all/0" do
    File.write!("history.json", Jason.encode!([]))

    History.save_entry(@sample_entry)

    history = History.get_all()
    assert length(history) == 1
    assert hd(history)["text"] == "こんにちは"
  end
end
