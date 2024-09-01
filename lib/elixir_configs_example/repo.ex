defmodule ElixirConfigsExample.Repo do
  use Ecto.Repo,
    otp_app: :elixir_configs_example,
    adapter: Ecto.Adapters.Postgres
end
