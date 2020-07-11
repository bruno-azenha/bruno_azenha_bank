defmodule BankPersistence.Account do
  use Ecto.Schema

  @timestamps_opts [inserted_at: :created_at, type: :utc_datetime_usec]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    timestamps()
  end

  def insert_changeset(account, params \\ %{}) do
    account
    |> Ecto.Changeset.cast(params, [:id])
    |> Ecto.Changeset.unique_constraint(:id, name: :accounts_pkey)
    |> Ecto.Changeset.validate_required([:id])
  end
end
