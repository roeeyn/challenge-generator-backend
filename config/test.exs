import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :challenge_generator, ChallengeGeneratorWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "v+hTczK4EZV4U5hLrdQr1cf9J2t3QAj/7mcUQAtdloFs9vFF5A15jZfdhUyQP/D1",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
