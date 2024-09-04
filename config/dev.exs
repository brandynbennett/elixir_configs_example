import Config

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false
