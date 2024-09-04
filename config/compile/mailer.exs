import Config

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :elixir_configs_example, ElixirConfigsExample.Mailer, adapter: Swoosh.Adapters.Local

if config_env() == :dev do
  # Disable swoosh api client as it is only required for production adapters.
  config :swoosh, :api_client, false
end

if config_env() == :test do
  # In test we don't send emails
  config :elixir_configs_example, ElixirConfigsExample.Mailer, adapter: Swoosh.Adapters.Test

  # Disable swoosh api client as it is only required for production adapters
  config :swoosh, :api_client, false
end

if config_env() == :prod do
  # Configures Swoosh API Client
  config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: ElixirConfigsExample.Finch

  # Disable Swoosh Local Memory Storage
  config :swoosh, local: false
end
