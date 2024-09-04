defmodule Shared.RuntimeConfig do
  @moduledoc """
  Use `RuntimeConfig` to make it easier to establish defaults for runtime config values.
  This for the purpose of keeping compile-time configs and runtime-configs separated.
  If something can be set at runtime we only want it to be used in `runtime.exs` so that
  we know where to look for it.

  ## Setup Example

  ```elixir
  # runtime.exs

  import Config

  defmodule RuntimeConfig do
    use Shared.RuntimeConfig

    def defaults do
      %{
        "DATABASE_URL" => [test: "localhost", dev: "localhost"]
      }
    end
  end
  ```

  ## Retrieving environment variables

  Use the `RuntimeConfig.get/2` function to fetch your environment variables. If a
  default has not been defined for the environment in `c:defaults/0` an
  error will be raised.

  If you want the value returned in a form other than a String, you can pass an optional
  `:cast` option to return a different type. Supported options include:

  * `:integer`
  * `:boolean`

  ```
    iex>RuntimeConfig.get("DATABASE_URL")
    "localhost"

    iex>RuntimeConfig.get("PORT", cast: :integer)
    4000

    iex>RuntimeConfig.get("FOO")
    (RuntimeError) environment variable FOO not set and no default for :dev
  ```
  """

  import Config

  @type envs :: {:prod, String.t()} | {:dev, String.t()} | {:test, String.t()}

  @callback defaults() :: %{
              String.t() => [envs()]
            }

  defmacro __using__(_opts) do
    quote do
      @behaviour Shared.RuntimeConfig

      def get(envvar, opts \\ []) do
        Shared.RuntimeConfig.get(envvar, defaults(), opts)
      end
    end
  end

  def get(envvar, defaults, opts \\ []) do
    value = System.get_env(envvar) || default(envvar, defaults, config_env())

    case Keyword.get(opts, :cast) do
      :integer ->
        value && String.to_integer(value)

      :boolean ->
        value in ["1", "true", "TRUE", true]

      # ... more casts

      nil ->
        value
    end
  end

  defp default(envvar, defaults, env) when is_map(defaults) do
    case Map.get(defaults, envvar) do
      nil ->
        raise("environment variable #{envvar} not set and no defaults configured")

      env_defaults ->
        env_default(envvar, env_defaults, env)
    end
  end

  defp env_default(envvar, defaults, env) do
    if Keyword.has_key?(defaults, env) do
      Keyword.get(defaults, env)
    else
      raise("environment variable #{envvar} not set and no default for #{inspect(env)}")
    end
  end
end
