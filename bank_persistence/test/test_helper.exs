ExUnit.configure(capture_log: true, exclude: :skip)
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(BankPersistence.Repo, :manual)
