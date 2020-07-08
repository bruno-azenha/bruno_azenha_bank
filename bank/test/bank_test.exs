defmodule BankTest do
  use Assertions.Case, async: true

  alias Bank.Account
  alias Bank.Transaction

  describe "create_account/0" do
    test "should create a new account and return it" do
      assert %Account{} = Bank.create_account()
    end

    test "id should be a UUID version 4" do
      %Account{id: id} = Bank.create_account()
      assert {:ok, [{:uuid, _}, _, _, {:version, 4}, _]} = UUID.info(id)
    end

    test "created accounts should have zero balance" do
      assert %Account{balance: 0} = Bank.create_account()
    end
  end

  describe "transfer/3" do
    test " returns the updated accounts and the resulting transactions" do
      id_1 = UUID.uuid4()
      id_2 = UUID.uuid4()
      account_1 = %Account{id: id_1, balance: 100}
      account_2 = %Account{id: id_2, balance: 0}

      {accounts, transactions} = Bank.transfer(%{from: account_1, to: account_2, amount: 100})

      assert_lists_equal(accounts, [
        %Account{id: id_1, balance: 0},
        %Account{id: id_2, balance: 100}
      ])

      assert_lists_equal(transactions, [
        %Transaction{from: id_1, to: id_2, amount: 100},
        %Transaction{from: id_2, to: id_1, amount: -100}
      ])
    end
  end
end
