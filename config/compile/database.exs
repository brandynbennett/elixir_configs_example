import Config

config :elixir_configs_example,
  ecto_repos: [ElixirConfigsExample.Repo],
  generators: [timestamp_type: :utc_datetime]

if config_env() == :dev do
  config :elixir_configs_example, ElixirConfigsExample.Repo,
    username: "postgres",
    password: "postgres",
    hostname: "localhost",
    database: "elixir_configs_example_dev",
    stacktrace: true,
    show_sensitive_data_on_connection_error: true
end
