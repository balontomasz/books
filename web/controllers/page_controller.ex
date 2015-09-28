defmodule Books.PageController do
  use Books.Web, :controller

  def index(conn, _params) do
    current_user = get_session(conn, :current_user)

    conn
    |> assign(:current_user, current_user)
    |> render "index.html"
  end
end
