Application.put_env(:bank, :bank_repo, Bank.PersistenceMock)

Hammox.defmock(Bank.PersistenceMock, for: Bank.Persistence)
