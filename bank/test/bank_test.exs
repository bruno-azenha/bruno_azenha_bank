defmodule BankTest do
  use ExUnit.Case, async: true

  alias Bank.Core.Account
  alias Bank.Core.Transaction

  import Hammox
  alias Bank.PersistenceMock

  setup :verify_on_exit!

  describe "create_account/0" do
    test "should create a new account with a UUID id, zero balance and no transactions" do
      PersistenceMock
      |> expect(:save_account, fn _account -> :ok end)

      %Account{id: id, balance: 0, transactions: []} = Bank.create_account()
      assert {:ok, [{:uuid, _}, _, _, {:version, 4}, _]} = UUID.info(id)
    end

    test "should return :error if Repo fails" do
      PersistenceMock
      |> expect(:save_account, fn _account -> {:error, :account_already_exists} end)

      assert Bank.create_account() == {:error, :account_already_exists}
    end
  end

  describe "account_summary/1" do
    test "compose the results of the Persistence app into an Account result" do
      sender_id = UUID.uuid4()
      receiver_id = UUID.uuid4()
      balance = -300
      amount = 100

      transaction_1 = transaction_response(sender_id, receiver_id, amount)
      transaction_2 = transaction_response(sender_id, receiver_id, amount)
      transaction_3 = transaction_response(sender_id, receiver_id, amount)
      latest_transactions_response = [transaction_1, transaction_2, transaction_3]

      transaction_limit = 10

      PersistenceMock
      |> expect(:get_balance, fn ^sender_id -> {:ok, balance} end)
      |> expect(:get_latest_transactions, fn ^sender_id, ^transaction_limit ->
        {:ok, latest_transactions_response}
      end)

      assert %Account{
               id: ^sender_id,
               balance: balance,
               transactions: transactions
             } = Bank.account_summary(sender_id)

      assert [
               %Transaction{
                 sender_id: ^sender_id,
                 receiver_id: ^receiver_id,
                 amount: ^amount,
                 created_at: _
               },
               %Transaction{
                 sender_id: ^sender_id,
                 receiver_id: ^receiver_id,
                 amount: ^amount,
                 created_at: _
               },
               %Transaction{
                 sender_id: ^sender_id,
                 receiver_id: ^receiver_id,
                 amount: ^amount,
                 created_at: _
               }
             ] = transactions
    end
  end

  describe "transfer_money/3" do
    test "should persist a transaction between the two accounts" do
      account_id_1 = UUID.uuid4()
      account_id_2 = UUID.uuid4()
      amount = 100

      PersistenceMock
      |> expect(:save_transaction, fn ^account_id_1, ^account_id_2, ^amount -> :ok end)

      assert Bank.transfer_money(account_id_1, account_id_2, amount) == :ok
    end
  end

  defp transaction_response(sender_id, receiver_id, amount) do
    %{
      sender_id: sender_id,
      receiver_id: receiver_id,
      amount: amount,
      created_at: DateTime.utc_now()
    }
  end
end
