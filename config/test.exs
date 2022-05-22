import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :challenge_generator, ChallengeGeneratorWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "bXgDNfTysSq3aIVLl/nvgoo32A1I1MVLuI+sUm6Dj5HaDGuZMJJUAKHoMGJnEIb+",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
