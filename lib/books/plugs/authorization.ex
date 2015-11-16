defmodule Books.Plugs.Authorization do
  import Plug.Conn

  def init(default), do: default
  def call(conn, _default) do
    if get_session(conn, :current_user) do
      conn
    else
      conn
      |> Phoenix.Controller
          .redirect(to: Books.Router.Helpers.auth_path(conn, :index, "google"))
      |> halt
    end
  end
end
