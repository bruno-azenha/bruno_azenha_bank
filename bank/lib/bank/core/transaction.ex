defmodule Bank.Core.Transaction do
  @type t() :: %__MODULE__{
          id: binary(),
          sender_id: binary(),
          receiver_id: binary(),
          amount: integer(),
          created_at: DateTime.t()
        }
  defstruct [:id, :sender_id, :receiver_id, :amount, :created_at]
end
