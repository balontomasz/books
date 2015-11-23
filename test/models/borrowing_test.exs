defmodule Books.BorrowingTest do
  use Books.ModelCase

  alias Books.Borrowing

  @valid_attrs %{returned_at: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Borrowing.changeset(%Borrowing{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Borrowing.changeset(%Borrowing{}, @invalid_attrs)
    refute changeset.valid?
  end
end
