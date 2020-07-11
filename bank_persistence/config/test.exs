import Config

config :bank_persistence, BankPersistence.Repo,
  database: "bank_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
