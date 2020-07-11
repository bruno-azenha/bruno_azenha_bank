defmodule BankPersistence.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      timestamps(inserted_at: :created_at, type: :utc_datetime_usec)
    end
  end
end
