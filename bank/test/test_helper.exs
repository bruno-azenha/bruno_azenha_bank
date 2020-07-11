Application.put_env(:bank, :bank_repo, Bank.PersistenceMock)
ExUnit.start()
