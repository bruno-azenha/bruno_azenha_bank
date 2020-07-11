defmodule BankPersistence.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      BankPersistence.Repo
    ]

    opts = [strategy: :one_for_one, name: BankPersistence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
