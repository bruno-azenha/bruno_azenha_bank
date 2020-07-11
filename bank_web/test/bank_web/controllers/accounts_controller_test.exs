defmodule BankWeb.AccountsControllerTest do
  use BankWeb.ConnCase

  import Hammox

  alias BankWeb.BankMock
  alias Bank.Core.Account
  alias Bank.Core.Transaction

  describe "create account" do
    test "renders a successfull 200 response with the new account summary", %{conn: conn} do
      account = %Account{id: UUID.uuid4(), balance: 0, transactions: []}

      BankMock
      |> expect(:create_account, fn -> account end)

      conn = post(conn, Routes.accounts_path(conn, :create, %{}))

      assert json_response(conn, 200) ==
               render_json("account_summary.json", %{account_summary: account})
    end
  end

  describe "get account" do
    test "renders a successfull 200 response with the account summary", %{conn: conn} do
      account_id = UUID.uuid4()

      transaction = %Transaction{
        id: "10",
        sender_id: account_id,
        receiver_id: UUID.uuid4(),
        amount: 1000,
        created_at: DateTime.utc_now()
      }

      account_summary = %Account{id: account_id, balance: 1000, transactions: [transaction]}

      BankMock
      |> expect(:account_summary, fn ^account_id, 10 -> account_summary end)

      conn = get(conn, Routes.accounts_path(conn, :show, account_id))

      assert json_response(conn, 200) ==
               render_json("account_summary.json", %{account_summary: account_summary})
    end

    test "returns 400 if id is not uuid", %{conn: conn} do
      account_id = "1"
      conn = get(conn, Routes.accounts_path(conn, :show, account_id))
      assert json_response(conn, 400)
    end
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    BankWeb.AccountsView.render(template, assigns)
    |> Jason.encode!()
    |> Jason.decode!()
  end
end
