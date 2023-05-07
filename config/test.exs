import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :amnesiac, Amnesiac.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "amnesiac_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10,
  migration_primary_key: [
    name: :id,
    type: :binary_id,
    autogenerate: false,
    read_after_writes: true,
    default: {:fragment, "uuid_generate_v4()"}
  ]

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :amnesiac, AmnesiacWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "IFtotbQHLqOnFwVmkpyV+R9owCW9USTevIfoU8AtgPPUqw2TyYMhO1ei3HQml5Ua",
  server: false

# In test we don't send emails.
config :amnesiac, Amnesiac.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
