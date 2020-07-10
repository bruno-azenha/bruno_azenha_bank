Application.put_env(:bank, :bank_repo, Bank.RepoMock)

Hammox.defmock(Bank.RepoMock, for: Bank.Repo)
