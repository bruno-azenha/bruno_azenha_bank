defmodule BankTest do
  use ExUnit.Case, async: true

  alias Bank.Core.Account

  import Hammox
  alias Bank.RepoMock

  setup :verify_on_exit!

  describe "create_account/0" do
    test "should create a new account with a UUID id, zero balance and no transactions" do
      RepoMock
      |> expect(:save_account, fn _account -> :ok end)

      %Account{id: id, balance: 0, transactions: []} = Bank.create_account()
      assert {:ok, [{:uuid, _}, _, _, {:version, 4}, _]} = UUID.info(id)
    end

    test "should return :error if Repo fails" do
      RepoMock
      |> expect(:save_account, fn _account -> :error end)

      assert Bank.create_account() == :error
    end
  end

  describe "account_summary/1" do
    test "compose the results of the Persistence app into an Account result" do
      t_account_id = UUID.uuid4()
      t_balance = 0
      t_transactions = []
      t_transaction_limit = 10

      RepoMock
      |> expect(:get_balance, fn ^t_account_id -> {:ok, t_balance} end)
      |> expect(:get_latest_transactions, fn ^t_account_id, ^t_transaction_limit -> {:ok, []} end)

      assert %Account{
               id: ^t_account_id,
               balance: ^t_balance,
               transactions: ^t_transactions
             } = Bank.account_summary(t_account_id)
    end
  end

  describe "transfer_money/3" do
    test "should persist a transaction between the two accounts" do
      account_id_1 = UUID.uuid4()
      account_id_2 = UUID.uuid4()
      amount = 100

      RepoMock
      |> expect(:save_money_transfer, fn ^account_id_1, ^account_id_2, ^amount -> :ok end)

      assert Bank.transfer_money(account_id_1, account_id_2, amount) == :ok
    end
  end
end
