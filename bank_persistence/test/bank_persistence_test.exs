defmodule BankPersistenceTest do
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(BankPersistence.Repo)
  end

  describe "save_account/1" do
    test "should return :ok when the account is persisted" do
      account_id = UUID.uuid4()
      assert :ok == BankPersistence.save_account(account_id)
    end

    test "should return :error if account with id already exist" do
      account_id = UUID.uuid4()
      assert :ok == BankPersistence.save_account(account_id)
      assert :error == BankPersistence.save_account(account_id)
    end
  end

  describe "save_transaction/3" do
    test "return :error if sender_account is not found" do
      sender_id = UUID.uuid4()
      receiver_id = UUID.uuid4()
      BankPersistence.save_account(receiver_id)
      amount = 100

      assert :error = BankPersistence.save_transaction(sender_id, receiver_id, amount)
    end

    test "return :error if receiver_account is not found" do
      sender_id = UUID.uuid4()
      receiver_id = UUID.uuid4()
      BankPersistence.save_account(sender_id)
      amount = 100

      assert :error = BankPersistence.save_transaction(sender_id, receiver_id, amount)
    end

    test "return :ok if transaction is saved successfully" do
      sender_id = UUID.uuid4()
      receiver_id = UUID.uuid4()
      BankPersistence.save_account(sender_id)
      BankPersistence.save_account(receiver_id)
      amount = 100

      BankPersistence.save_account(sender_id)
      assert :ok = BankPersistence.save_transaction(sender_id, receiver_id, amount)
    end

    test "return :error if sender_id and receiver_id are the same" do
      account_id = UUID.uuid4()
      BankPersistence.save_account(account_id)
      amount = 100

      assert :error = BankPersistence.save_transaction(account_id, account_id, amount)
    end
  end

  describe "get_latest_transactions" do
    test "should return {:ok, []} if there are no transactions for that account" do
      account_id = UUID.uuid4()
      max = 10
      :ok = BankPersistence.save_account(account_id)
      assert {:ok, []} == BankPersistence.get_latest_transactions(account_id, max)
    end

    test "should return :error if the account does not exist" do
      account_id = UUID.uuid4()
      max = 10

      assert {:error, :account_not_found} ==
               BankPersistence.get_latest_transactions(account_id, max)
    end

    test "should return {:ok, [transaction]} where there is just one transaction" do
      account_id = UUID.uuid4()
      receiver_id = UUID.uuid4()
      amount = 100
      max = 10
      :ok = BankPersistence.save_account(account_id)
      :ok = BankPersistence.save_account(receiver_id)

      :ok = BankPersistence.save_transaction(account_id, receiver_id, amount)

      assert {:ok,
              [
                %{from: ^account_id, to: ^receiver_id, amount: amount}
              ]} = BankPersistence.get_latest_transactions(account_id, max)
    end
  end
end
