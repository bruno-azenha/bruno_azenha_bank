defmodule BankPersistence do
  alias BankPersistence.Repo
  alias BankPersistence.Account
  alias BankPersistence.Transaction

  import Ecto.Query, only: [from: 2]

  @spec save_account(binary()) :: :ok | :error
  def save_account(id) do
    %Account{id: id}
    |> Account.insert_changeset()
    |> Repo.insert()
    |> case do
      {:ok, _} -> :ok
      _ -> :error
    end
  end

  @spec save_transaction(binary(), binary(), integer()) :: :ok | :error
  def save_transaction(same_account_id, same_account_id, _amount), do: :error

  def save_transaction(sender_id, receiver_id, amount) do
    with %Account{id: ^sender_id} <- Repo.get(Account, sender_id),
         %Account{id: ^receiver_id} <- Repo.get(Account, receiver_id) do
      %Transaction{
        sender_id: sender_id,
        receiver_id: receiver_id,
        amount: amount
      }
      |> Transaction.insert_changeset()
      |> Repo.insert()

      :ok
    else
      _ -> :error
    end
  end

  @spec get_latest_transactions(binary(), integer()) ::
          {:ok, [%{from: binary(), to: binary(), amount: integer()}]}
          | {:error, :account_not_found}
  def get_latest_transactions(account_id, _max) do
    with %Account{} <- Repo.get(Account, account_id) do
      query =
        from(t in Transaction, where: t.sender_id == ^account_id or t.receiver_id == ^account_id)

      transactions =
        query
        |> Repo.all()
        |> Enum.map(&convert_to_response_map/1)

      {:ok, transactions}
    else
      _ -> {:error, :account_not_found}
    end
  end

  defp convert_to_response_map(transaction = %Transaction{}) do
    %{
      from: transaction.sender_id,
      to: transaction.receiver_id,
      amount: transaction.amount
    }
  end

  # @callback get_balance(binary()) :: {:ok, integer()} | nil
  # @callback get_latest_transactions(binary(), integer()) ::
  #             {:ok, [%{from: binary(), to: binary(), amount: integer()}]}
  #             | {:error, :not_found}
  # @callback save_money_transfer(binary(), binary(), integer()) :: :ok | :error
end
