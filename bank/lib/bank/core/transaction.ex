defmodule Bank.Core.Transaction do
  alias Bank.Core.Account

  @type t() :: %__MODULE__{
          id: binary(),
          sender_account_id: binary(),
          receiver_account_id: binary(),
          amount: integer()
        }
  defstruct [:id, :sender_account_id, :receiver_account_id, :amount]

  def new(%Account{} = sender_account, %Account{} = receiver_account, amount) do
    %__MODULE__{
      id: UUID.uuid4(),
      sender_account_id: sender_account.id,
      receiver_account_id: receiver_account.id,
      amount: amount
    }
  end
end
