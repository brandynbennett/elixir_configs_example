import Config

# Configures the endpoint
config :elixir_configs_example, ElixirConfigsExampleWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: ElixirConfigsExampleWeb.ErrorHTML, json: ElixirConfigsExampleWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ElixirConfigsExample.PubSub,
  live_view: [signing_salt: "y5U/MUPh"]
