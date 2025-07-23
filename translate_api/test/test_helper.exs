ExUnit.start()

Dotenvy.source!(Path.expand("../.env", __DIR__)) |> Enum.each(fn {k, v} -> System.put_env(k, v) end)
