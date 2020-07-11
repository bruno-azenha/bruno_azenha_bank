defmodule BankWeb.Bank do
  alias Bank.Core.Account

  @callback create_account() :: Account.t()
  @callback account_summary(binary(), integer()) :: Account.t() | {:error, :account_not_found}
  @callback transfer_money(binary(), binary(), integer()) ::
              {:ok, binary()} | {:error, :account_not_found} | {:error, :same_sender_and_receiver}

  @bank_module Application.get_env(:bank_web, :bank_module, Bank)

  @spec create_account() :: Account.t() | {:error, :account_already_exists}
  defdelegate create_account(), to: @bank_module

  @spec account_summary(binary(), integer()) :: Account.t() | {:error, :account_not_found}
  defdelegate account_summary(id, max_transactions), to: @bank_module

  @spec transfer_money(binary(), binary(), integer()) ::
          {:ok, binary()} | {:error, :account_not_found} | {:error, :same_sender_and_receiver}
  defdelegate transfer_money(sender_id, receiver_id, amount), to: @bank_module

  def validate_id(id) do
    case UUID.info(id) do
      {:ok, [_, _, _, {:version, 4}, _]} -> :valid
      _ -> :invalid
    end
  end
end
