defmodule BankWeb.BankView do
  use BankWeb, :view

  alias Bank.Core.Account
  alias Bank.Core.Transaction

  def render("account_summary.json", %{account_summary: account_summary}) do
    %{
      account_summary: account_summary_json(account_summary)
    }
  end

  def account_summary_json(account_summary = %Account{id: account_id}) do
    transactions =
      Enum.map(account_summary.transactions, fn t -> transaction_json(t, account_id) end)

    %{
      id: account_id,
      balance: account_summary.balance,
      transactions: transactions
    }
  end

  def transaction_json(
        %Transaction{
          id: id,
          sender_id: same_account_id,
          receiver_id: receiver_id,
          amount: amount,
          created_at: created_at
        },
        same_account_id
      ) do
    %{id: id, sent: amount, to: receiver_id, at: created_at}
  end

  def transaction_json(
        %Transaction{
          id: id,
          sender_id: sender_id,
          receiver_id: same_account_id,
          amount: amount,
          created_at: created_at
        },
        same_account_id
      ) do
    %{id: id, received: amount, from: sender_id, at: created_at}
  end
end
