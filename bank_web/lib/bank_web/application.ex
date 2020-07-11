defmodule BankWeb.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      BankWeb.Telemetry,
      {Phoenix.PubSub, name: BankWeb.PubSub},
      BankWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: BankWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    BankWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
