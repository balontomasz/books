defmodule Books.BorrowingController do
  use Books.Web, :controller

  alias Books.Borrowing

  plug :scrub_params, "borrowing" when action in [:create, :update]

  def index(conn, _params) do
    borrowings = Repo.all(Borrowing)
    render(conn, "index.html", borrowings: borrowings)
  end

  def new(conn, _params) do
    changeset = Borrowing.changeset(%Borrowing{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"borrowing" => borrowing_params}) do
    changeset = Borrowing.changeset(%Borrowing{}, borrowing_params)

    case Repo.insert(changeset) do
      {:ok, _borrowing} ->
        conn
        |> put_flash(:info, "Borrowing created successfully.")
        |> redirect(to: borrowing_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    borrowing = Repo.get!(Borrowing, id)
    render(conn, "show.html", borrowing: borrowing)
  end

  def edit(conn, %{"id" => id}) do
    borrowing = Repo.get!(Borrowing, id)
    changeset = Borrowing.changeset(borrowing)
    render(conn, "edit.html", borrowing: borrowing, changeset: changeset)
  end

  def update(conn, %{"id" => id, "borrowing" => borrowing_params}) do
    borrowing = Repo.get!(Borrowing, id)
    changeset = Borrowing.changeset(borrowing, borrowing_params)

    case Repo.update(changeset) do
      {:ok, borrowing} ->
        conn
        |> put_flash(:info, "Borrowing updated successfully.")
        |> redirect(to: borrowing_path(conn, :show, borrowing))
      {:error, changeset} ->
        render(conn, "edit.html", borrowing: borrowing, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    borrowing = Repo.get!(Borrowing, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(borrowing)

    conn
    |> put_flash(:info, "Borrowing deleted successfully.")
    |> redirect(to: borrowing_path(conn, :index))
  end
end
