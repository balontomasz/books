defmodule Books.BorrowingControllerTest do
  use Books.ConnCase

  alias Books.Borrowing
  @valid_attrs %{returned_at: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, borrowing_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing borrowings"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, borrowing_path(conn, :new)
    assert html_response(conn, 200) =~ "New borrowing"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, borrowing_path(conn, :create), borrowing: @valid_attrs
    assert redirected_to(conn) == borrowing_path(conn, :index)
    assert Repo.get_by(Borrowing, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, borrowing_path(conn, :create), borrowing: @invalid_attrs
    assert html_response(conn, 200) =~ "New borrowing"
  end

  test "shows chosen resource", %{conn: conn} do
    borrowing = Repo.insert! %Borrowing{}
    conn = get conn, borrowing_path(conn, :show, borrowing)
    assert html_response(conn, 200) =~ "Show borrowing"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, borrowing_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    borrowing = Repo.insert! %Borrowing{}
    conn = get conn, borrowing_path(conn, :edit, borrowing)
    assert html_response(conn, 200) =~ "Edit borrowing"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    borrowing = Repo.insert! %Borrowing{}
    conn = put conn, borrowing_path(conn, :update, borrowing), borrowing: @valid_attrs
    assert redirected_to(conn) == borrowing_path(conn, :show, borrowing)
    assert Repo.get_by(Borrowing, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    borrowing = Repo.insert! %Borrowing{}
    conn = put conn, borrowing_path(conn, :update, borrowing), borrowing: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit borrowing"
  end

  test "deletes chosen resource", %{conn: conn} do
    borrowing = Repo.insert! %Borrowing{}
    conn = delete conn, borrowing_path(conn, :delete, borrowing)
    assert redirected_to(conn) == borrowing_path(conn, :index)
    refute Repo.get(Borrowing, borrowing.id)
  end
end
