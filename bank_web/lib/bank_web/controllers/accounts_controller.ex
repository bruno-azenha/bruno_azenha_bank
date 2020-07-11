defmodule BankWeb.AccountsController do
  use BankWeb, :controller

  require Logger
  alias Bank.Core.Account

  action_fallback(BankWeb.FallbackController)

  def create(conn, _params) do
    with %Account{} = account <- BankWeb.Bank.create_account() do
      render(conn, "account_summary.json", %{account_summary: account})
    end
  end

  def show(conn, %{"id" => account_id}) do
    with :valid <- BankWeb.Bank.validate_id(account_id),
         %Account{} = account <- BankWeb.Bank.account_summary(account_id, 10) do
      render(conn, "account_summary.json", %{account_summary: account})
    else
      :invalid -> {:error, :invalid_id_format}
    end
  end
end
