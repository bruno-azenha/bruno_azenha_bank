defmodule Bank do
  @moduledoc """
  Bank is a nice little project that simulates the behaviour of a very simple Bank.
  There are Accounts, Transactions, Balances. Everything you expect, but all fake.
  :)
  """

  alias Bank.Core.Account
  alias Bank.Core.Transaction
  alias Bank.Persistence

  @doc """
  Create an Account with unique id and 0 balance and no transactions
  """
  @spec create_account() :: Account.t() | {:error, :account_already_exists}
  def create_account() do
    account = Account.new()

    with :ok <- Persistence.save_account(account.id) do
      account
    end
  end

  @doc """
  Returns the account summary including the latest 10 transactions
  """
  @spec account_summary(binary(), integer()) :: Account.t() | :error
  def account_summary(id, max_transactions \\ 10) do
    with {:ok, balance} <- Persistence.get_balance(id),
         {:ok, latest_transactions} <- Persistence.get_latest_transactions(id, max_transactions) do
      %Account{
        id: id,
        balance: balance,
        transactions: Enum.map(latest_transactions, &struct(Transaction, &1))
      }
    end
  end

  @spec transfer_money(binary(), binary(), integer()) :: :ok | :error
  def transfer_money(sender_id, receiver_id, amount) do
    Persistence.save_transaction(sender_id, receiver_id, amount)
  end
end
