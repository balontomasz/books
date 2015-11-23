defmodule Books.Repo.Migrations.CreateBorrowing do
  use Ecto.Migration

  def change do
    create table(:borrowings) do
      add :returned_at, :datetime
      add :user_id, references(:users)
      add :book_id, references(:books)

      timestamps
    end
    create index(:borrowings, [:user_id])
    create index(:borrowings, [:book_id])

  end
end
