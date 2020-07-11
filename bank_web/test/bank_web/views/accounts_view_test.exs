defmodule BankWeb.AccountsViewTest do
  use BankWeb.ConnCase, async: true

  import Phoenix.View
  alias Bank.Core.Account
  alias Bank.Core.Transaction

  test "renders account_summary.json" do
    created_at_2 = DateTime.utc_now()
    created_at_1 = DateTime.utc_now()

    account_summary = %Account{
      id: "1",
      balance: 2000,
      transactions: [
        %Transaction{
          id: "transaction_id_1",
          sender_id: "1",
          receiver_id: "2",
          amount: 1000,
          created_at: created_at_2
        },
        %Transaction{
          id: "transaction_id_2",
          sender_id: "2",
          receiver_id: "1",
          amount: 3000,
          created_at: created_at_1
        }
      ]
    }

    rendered_account_summary =
      render(BankWeb.AccountsView, "account_summary.json", %{account_summary: account_summary})

    assert rendered_account_summary == %{
             account_summary: %{
               id: "1",
               balance: 2000,
               transactions: [
                 %{id: "transaction_id_1", sent: 1000, to: "2", at: created_at_2},
                 %{id: "transaction_id_2", received: 3000, from: "2", at: created_at_1}
               ]
             }
           }
  end
end
