import Config

config :elixir_configs_example,
  ecto_repos: [ElixirConfigsExample.Repo],
  generators: [timestamp_type: :utc_datetime]
