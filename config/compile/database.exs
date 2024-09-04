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

if config_env() == :test do
  # Configure your database
  #
  # The MIX_TEST_PARTITION environment variable can be used
  # to provide built-in test partitioning in CI environment.
  # Run `mix help test` for more information.
  config :elixir_configs_example, ElixirConfigsExample.Repo,
    username: "postgres",
    password: "postgres",
    hostname: "localhost",
    database: "elixir_configs_example_test#{System.get_env("MIX_TEST_PARTITION")}",
    pool: Ecto.Adapters.SQL.Sandbox
end
