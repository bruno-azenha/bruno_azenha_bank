defmodule BankTest do
  use ExUnit.Case

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
end
