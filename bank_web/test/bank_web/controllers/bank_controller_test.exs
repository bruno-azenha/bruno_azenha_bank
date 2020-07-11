defmodule BankWeb.BankControllerTest do
  use BankWeb.ConnCase

  import Hammox

  alias BankWeb.BankMock
  alias Bank.Core.Account

  describe "create account" do
    test "renders a successfull 200 response with the new account summary", %{conn: conn} do
      account = %Account{id: "1", balance: 0, transactions: []}

      BankMock
      |> expect(:create_account, fn -> account end)

      conn = post(conn, Routes.bank_path(conn, :create, %{}))

      assert json_response(conn, 200) ==
               render_json("account_summary.json", %{account_summary: account})
    end
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    BankWeb.BankView.render(template, assigns)
    |> Jason.encode!()
    |> Jason.decode!()
  end
end
