defmodule BankWeb.TransactionsControllerTest do
  use BankWeb.ConnCase

  import Hammox

  alias BankWeb.BankMock

  describe "transfer_money" do
    test "renders a successfull 200 response with the transaction id", %{conn: conn} do
      transaction_id = "transaction_id"

      sender_id = UUID.uuid4()
      receiver_id = UUID.uuid4()
      amount = 1000

      request = %{
        sender_id: sender_id,
        receiver_id: receiver_id,
        amount: amount
      }

      BankMock
      |> expect(:transfer_money, fn ^sender_id, ^receiver_id, ^amount -> {:ok, transaction_id} end)

      conn = post(conn, Routes.transactions_path(conn, :create, request))

      assert json_response(conn, 200) == %{"transaction_id" => "transaction_id"}
    end

    test "renders a successfull 400 if id is not uuid", %{conn: conn} do
      sender_id = "1"
      receiver_id = "2"
      amount = 1000

      request = %{
        sender_id: sender_id,
        receiver_id: receiver_id,
        amount: amount
      }

      conn = post(conn, Routes.transactions_path(conn, :create, request))

      assert json_response(conn, 400)
    end
  end
end
