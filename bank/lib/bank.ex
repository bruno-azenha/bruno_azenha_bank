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
end
