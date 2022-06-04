# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :challenge_generator, ChallengeGeneratorWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ChallengeGeneratorWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ChallengeGenerator.PubSub,
  live_view: [signing_salt: "Hja5QpPA"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :challenge_generator, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: ChallengeGeneratorWeb.Router,
      endpoint: ChallengeGeneratorWeb.Endpoint
    ]
  }

config :phoenix_swagger, json_library: Jason

# Tailwind CSS
config :tailwind,
  version: "3.0.24",
  default: [
    args: ~w(
    --config=tailwind.config.js
    --input=css/app.css
    --output=../priv/static/assets/app.css
  ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
