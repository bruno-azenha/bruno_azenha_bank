defmodule BankPersistence.Repo do
  use Ecto.Repo,
    otp_app: :bank_persistence,
    adapter: Ecto.Adapters.Postgres
end
