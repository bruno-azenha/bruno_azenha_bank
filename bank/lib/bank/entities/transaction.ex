defmodule Bank.Transaction do
  @type t() :: %__MODULE__{
          from: binary(),
          to: binary(),
          amount: integer()
        }

  defstruct [:id, :from, :to, :amount]
end
