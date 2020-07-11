defmodule BankPersistence.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:sender_id, references(:accounts, type: :uuid))
      add(:receiver_id, references(:accounts, type: :uuid))
      add(:amount, :integer)
      timestamps()
    end

    create(
      constraint(:transactions, :sender_and_receiver_must_be_different,
        check: "sender_id <> receiver_id"
      )
    )

    create(index(:transactions, [:sender_id, :inserted_at]))
    create(index(:transactions, [:receiver_id, :inserted_at]))
    create(index(:transactions, [:inserted_at]))
  end
end
