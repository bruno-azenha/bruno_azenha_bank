import Config

config :bank_persistence, BankPersistence.Repo,
  database: "bank",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :bank_persistence,
  ecto_repos: [BankPersistence.Repo]

import_config "#{Mix.env()}.exs"
