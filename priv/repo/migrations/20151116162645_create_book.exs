defmodule Books.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :author, :string
      add :title, :string
      add :isbn, :string
      add :cover, :string
      add :description, :text

      timestamps
    end

  end
end
