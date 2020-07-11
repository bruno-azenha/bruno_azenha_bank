defmodule Bank do
  @moduledoc """
  Bank is a nice little project that simulates the behaviour of a very simple Bank.
  There are Accounts, Transactions, Balances. Everything you expect, but all fake.
  :)
  """

  alias Bank.Core.Account
  alias Bank.Repo

  # alias Bank.Core.Transaction

  @doc """
  Create an Account with unique id and 0 balance and no transactions
  """
  @spec create_account() :: Account.t() | :error
  def create_account() do
    account = Account.new()

    case Repo.save_account(account.id) do
      :ok -> account
      :error -> :error
    end
  end

  @spec account_summary(binary()) :: Account.t() | :error
  def account_summary(id) do
    with {:ok, balance} <- Repo.get_balance(id),
         {:ok, latest_transactions} <- Repo.get_latest_transactions(id, 10) do
      %Account{
        id: id,
        balance: balance,
        transactions: latest_transactions
      }
    else
      _ -> :error
    end
  end

  @spec transfer_money(binary(), binary(), integer()) :: :ok | :error
  def transfer_money(sender_id, receiver_id, amount) do
    case Repo.save_transaction(sender_id, receiver_id, amount) do
      :ok -> :ok
      _ -> :error
    end
  end
end
