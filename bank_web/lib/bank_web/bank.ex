defmodule BankWeb.Bank do
  alias Bank.Core.Account

  @callback create_account() :: Account.t() | {:error, :account_already_exists}
  @callback account_summary(binary(), integer()) :: Account.t() | {:error, :account_not_found}
  @callback transfer_money(binary(), binary(), integer()) ::
              :ok | {:error, :account_not_found} | {:error, :same_sender_and_receiver}

  @bank_module Application.get_env(:bank_web, :bank_module, Bank)

  defdelegate create_account(), to: @bank_module
  defdelegate account_summary(id, max_transactions), to: @bank_module
  defdelegate transfer_money(sender_id, receiver_id, amount), to: @bank_module
end
