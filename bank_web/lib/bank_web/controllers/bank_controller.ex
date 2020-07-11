defmodule BankWeb.BankController do
  use BankWeb, :controller

  require Logger
  alias Bank.Core.Account

  action_fallback(BankWeb.FallbackController)

  def create(conn, _params) do
    with %Account{} = account <- BankWeb.Bank.create_account() do
      render(conn, "account_summary.json", %{account_summary: account})
    end
  end
end
