defmodule Bank.Repo do
  alias Bank.Core.Account

  @callback save_account(binary()) :: :ok | :error
  @callback get_balance(binary()) :: {:ok, integer()} | nil
  @callback get_latest_transactions(binary(), integer()) ::
              {:ok, [%{from: binary(), to: binary(), amount: integer()}]}
              | {:error, :not_found}
  @callback save_money_transfer(binary(), binary(), integer()) :: :ok | :error

  ##########

  @bank_repo Application.get_env(:bank, :bank_repo, BankPersistence)

  @spec save_account(Account.t()) :: :ok | :error
  defdelegate save_account(account), to: @bank_repo

  @spec get_balance(binary()) :: {:ok, integer()} | {:error, :not_found}
  defdelegate get_balance(id), to: @bank_repo

  @spec get_latest_transactions(binary(), integer()) ::
          {:ok, [%{from: binary(), to: binary(), amount: integer()}]}
          | {:error, :not_found}
  defdelegate get_latest_transactions(id, limit), to: @bank_repo

  @spec save_money_transfer(binary(), binary(), integer()) :: :ok | :error
  defdelegate save_money_transfer(sender_id, receiver_id, amount), to: @bank_repo
end
