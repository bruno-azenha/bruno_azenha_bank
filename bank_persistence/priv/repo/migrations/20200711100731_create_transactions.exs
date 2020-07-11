defmodule BankPersistence.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:sender_id, references(:accounts, type: :uuid))
      add(:receiver_id, references(:accounts, type: :uuid))
      add(:amount, :integer)
      timestamps(inserted_at: :created_at, updated_at: false, type: :utc_datetime_usec)
    end

    create(
      constraint(:transactions, :sender_and_receiver_must_be_different,
        check: "sender_id <> receiver_id"
      )
    )

    create(index(:transactions, [:sender_id, :created_at]))
    create(index(:transactions, [:receiver_id, :created_at]))
    create(index(:transactions, [:created_at]))
  end
end
