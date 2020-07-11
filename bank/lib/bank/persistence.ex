defmodule Bank.Persistence do
  @callback save_account(binary()) :: :ok | {:error, :account_already_exists}

  @callback get_account_balance(binary()) :: {:ok, integer()} | {:error, :account_not_found}

  @callback get_latest_transactions(binary(), integer()) ::
              {:ok,
               [
                 %{
                   id: binary(),
                   sender_id: binary(),
                   receiver_id: binary(),
                   amount: integer(),
                   created_at: DateTime.t()
                 }
               ]}
              | {:error, :account_not_found}

  @callback save_transaction(binary(), binary(), integer()) ::
              {:ok, binary()}
              | {:error, :account_not_found}
              | {:error, :same_sender_and_receiver}
              | :error

  ##########

  @bank_repo Application.get_env(:bank, :bank_repo, BankPersistence)

  @spec save_account(binary()) :: :ok | {:error, :account_already_exists}
  defdelegate save_account(account), to: @bank_repo

  @spec get_account_balance(binary()) :: {:ok, integer()} | {:error, :account_not_found}
  defdelegate get_account_balance(id), to: @bank_repo

  @spec get_latest_transactions(binary(), integer()) ::
          {:ok,
           [
             %{
               id: binary(),
               sender_id: binary(),
               receiver_id: binary(),
               amount: integer(),
               created_at: DateTime.t()
             }
           ]}
          | {:error, :account_not_found}
  defdelegate get_latest_transactions(id, limit), to: @bank_repo

  @spec save_transaction(binary(), binary(), integer()) ::
          {:ok, binary()}
          | {:error, :account_not_found}
          | {:error, :same_sender_and_receiver}
          | :error
  defdelegate save_transaction(sender_id, receiver_id, amount), to: @bank_repo
end
