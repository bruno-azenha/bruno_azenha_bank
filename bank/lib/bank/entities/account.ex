defmodule Bank.Account do
  @type t() :: %__MODULE__{
          id: binary(),
          balance: integer()
        }

  defstruct [:id, :balance]
end
