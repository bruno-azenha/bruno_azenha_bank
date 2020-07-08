defmodule Bank do
  @moduledoc """
  Bank is a nice little project that simulates the behaviour of a very simple Bank.
  There are Accounts, Transactions, Balances. Everything you expect, but all fake.
  :)
  """

  alias Bank.Account
  alias Bank.Transaction

  @doc """
  Create an Account with unique id and 0 balance
  """
  @spec create_account() :: Account.t()
  def create_account() do
    %Account{id: UUID.uuid4(), balance: 0}
  end

  @spec transfer(%{from: Account.t(), to: Account.t(), amount: integer()}) ::
          {[Account.t()], [Transaction.t()]}
  def transfer(%{from: account_1, to: account_2, amount: amount}) do
    {
      [
        struct(account_1, balance: account_1.balance - amount),
        struct(account_2, balance: account_2.balance + amount)
      ],
      [
        %Transaction{from: account_1.id, to: account_2.id, amount: amount},
        %Transaction{from: account_2.id, to: account_1.id, amount: -amount}
      ]
    }
  end
end
