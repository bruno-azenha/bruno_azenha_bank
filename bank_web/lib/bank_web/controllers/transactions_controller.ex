defmodule BankWeb.TransactionsController do
  use BankWeb, :controller

  require Logger

  action_fallback(BankWeb.FallbackController)

  def create(conn, params) do
    with %{"sender_id" => sender_id, "receiver_id" => receiver_id, "amount" => amount} <- params,
         :valid <- BankWeb.Bank.validate_id(sender_id),
         :valid <- BankWeb.Bank.validate_id(receiver_id),
         {parsed_amount, _} <- Integer.parse(amount),
         {:ok, transaction_id} <-
           BankWeb.Bank.transfer_money(sender_id, receiver_id, parsed_amount) do
      conn
      |> put_status(200)
      |> json(%{transaction_id: transaction_id})
    else
      :invalid ->
        {:error, :invalid_id_format}

      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{message: "Please provide sender_id, receiver_id as UUID and amount in CENTS!"})
    end
  end
end
