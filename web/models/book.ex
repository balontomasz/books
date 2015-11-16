defmodule Books.Book do
  use Books.Web, :model

  schema "books" do
    field :author, :string
    field :title, :string
    field :isbn, :string
    field :cover, :string
    field :description, :string

    timestamps
  end

  @required_fields ~w(author title isbn)
  @optional_fields ~w(cover description)

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
