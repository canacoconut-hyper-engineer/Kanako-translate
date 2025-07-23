defmodule TranslateApi.Application do
  use Application

  def start(_type, _args) do
    # ✅ 正しい使い方：source! + load
    ".env"
    |> Path.expand()
    |> Dotenvy.source!()
    |> Enum.each(fn {k, v} -> System.put_env(k, v) end)

    children = [
      {Plug.Cowboy, scheme: :http, plug: TranslateApi.Router, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: TranslateApi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end