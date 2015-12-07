defmodule Books.Borrowing do
  use Books.Web, :model

  schema "borrowings" do
    field :returned_at, Ecto.DateTime
    belongs_to :user, Books.User
    belongs_to :book, Books.Book

    timestamps
  end

  @required_fields ~w(book_id user_id)
  @optional_fields ~w(returned_at)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
