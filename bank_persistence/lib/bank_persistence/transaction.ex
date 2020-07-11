defmodule BankPersistence.Transaction do
  use Ecto.Schema

  alias BankPersistence.Account

  @timestamps_opts [inserted_at: :created_at, updated_at: false, type: :utc_datetime_usec]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    belongs_to(:sender, Account)
    belongs_to(:receiver, Account)
    field(:amount, :integer)

    timestamps()
  end

  def insert_changeset(transaction, params \\ %{}) do
    transaction
    |> Ecto.Changeset.cast(params, [:sender_id, :receiver_id, :amount])
    |> Ecto.Changeset.check_constraint(:sender_id, name: :sender_and_receiver_must_be_different)
    |> Ecto.Changeset.validate_required([:sender_id, :receiver_id, :amount])
  end
end
