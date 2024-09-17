import Config

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

if config_env() == :dev do
  # Enable dev routes for dashboard and mailbox
  config :elixir_configs_example, dev_routes: true

  # Set a higher stacktrace during development. Avoid configuring such
  # in production as building large stacktraces may be expensive.
  config :phoenix, :stacktrace_depth, 20

  # Initialize plugs at runtime for faster development compilation
  config :phoenix, :plug_init_mode, :runtime

  config :phoenix_live_view,
    # Include HEEx debug annotations as HTML comments in rendered markup
    debug_heex_annotations: true,
    # Enable helpful, but potentially expensive runtime checks
    enable_expensive_runtime_checks: true
end

if config_env() == :test do
  # Initialize plugs at runtime for faster test compilation
  config :phoenix, :plug_init_mode, :runtime

  # Enable helpful, but potentially expensive runtime checks
  config :phoenix_live_view,
    enable_expensive_runtime_checks: true
end
