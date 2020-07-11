defmodule BankPersistence.Transaction do
  use Ecto.Schema

  import Ecto.Query, only: [from: 2]
  alias BankPersistence.Account
  alias BankPersistence.Repo

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

  def save(sender_id, receiver_id, amount) do
    %__MODULE__{}
    |> __MODULE__.insert_changeset(%{
      sender_id: sender_id,
      receiver_id: receiver_id,
      amount: amount
    })
    |> Repo.insert()
  end

  def get_all_by_account_id(id) do
    from(t in __MODULE__,
      where: t.sender_id == ^id or t.receiver_id == ^id
    )
    |> Repo.all()
  end

  def get_latest_by_account_id(id, max) do
    from(t in __MODULE__,
      where: t.sender_id == ^id or t.receiver_id == ^id,
      order_by: [desc: t.created_at],
      limit: ^max
    )
    |> Repo.all()
  end
end
