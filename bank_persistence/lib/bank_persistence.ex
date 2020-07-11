defmodule BankPersistence do
  alias BankPersistence.Account
  alias BankPersistence.Transaction

  @spec save_account(binary()) :: :ok | {:error, :account_already_exists}
  def save_account(account_id) do
    case Account.save(account_id) do
      {:ok, _} -> :ok
      _ -> {:error, :account_already_exists}
    end
  end

  @spec save_transaction(binary(), binary(), integer()) ::
          :ok | {:error, :account_not_found} | {:error, :same_sender_and_receiver} | :error
  def save_transaction(same_account_id, same_account_id, _amount),
    do: {:error, :same_sender_and_receiver}

  def save_transaction(sender_id, receiver_id, amount) do
    with {:account, true} <- {:account, Account.exists?(sender_id)},
         {:account, true} <- {:account, Account.exists?(receiver_id)},
         {:ok, transaction} <- Transaction.save(sender_id, receiver_id, amount) do
      {:ok, transaction.id}
    else
      {:account, false} -> {:error, :account_not_found}
      _ -> :error
    end
  end

  @spec get_latest_transactions(binary(), integer()) ::
          {:ok, [%{from: binary(), to: binary(), amount: integer(), created_at: DateTime.t()}]}
          | {:error, :account_not_found}
  def get_latest_transactions(account_id, max) do
    with true <- Account.exists?(account_id) do
      transactions =
        Transaction.get_latest_by_account_id(account_id, max)
        |> Enum.map(&convert_to_response_map/1)

      {:ok, transactions}
    else
      _ -> {:error, :account_not_found}
    end
  end

  defp convert_to_response_map(transaction = %Transaction{}) do
    %{
      id: transaction.id,
      from: transaction.sender_id,
      to: transaction.receiver_id,
      amount: transaction.amount,
      created_at: transaction.created_at
    }
  end

  @spec get_account_balance(binary()) :: {:ok, integer()} | {:error, :account_not_found}
  def get_account_balance(account_id) do
    with true <- Account.exists?(account_id) do
      balance =
        account_id
        |> Transaction.get_all_by_account_id()
        |> calculate_resulting_balance(account_id)

      {:ok, balance}
    else
      _ -> {:error, :account_not_found}
    end
  end

  defp calculate_resulting_balance(transactions, account_id) do
    transactions
    |> Enum.reduce(0, fn t, acc -> sum_or_subtract(account_id, t).(acc) end)
  end

  defp sum_or_subtract(account_id, transaction = %Transaction{}) do
    case account_id == transaction.sender_id do
      true -> &(&1 - transaction.amount)
      false -> &(&1 + transaction.amount)
    end
  end
end
