defmodule Bank.Core.Account do
  alias Bank.Core.Transaction

  @type t() :: %__MODULE__{
          id: binary(),
          balance: integer(),
          transactions: [Transaction.t()]
        }

  defstruct [:id, :balance, :transactions]

  def new() do
    %__MODULE__{
      id: UUID.uuid4(),
      balance: 0,
      transactions: []
    }
  end
end
