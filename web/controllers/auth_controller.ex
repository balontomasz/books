defmodule Books.AuthController do
  use Books.Web, :controller

  def index(conn, %{"provider" => provider}) do
    redirect conn, external: authorize_url!(provider)
  end

  def callback(conn, %{"provider" => provider, "code" => code}) do
    token = get_token!(provider, code)
    user = get_user!(provider, token)

    user_params = %{email: user["email"], name: user["name"], uid: user["sub"]}

    if is_nil(Books.Repo.get_by(Books.User, user_params)) do
      changeset = Books.User.changeset(%Books.User{}, user_params)
      Books.Repo.insert(changeset)
    end

    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, token.access_token)
    |> redirect(to: "/")
  end

  defp authorize_url!("google"), do: Google.authorize_url!(scope: "email profile")
  defp authorize_url!(_), do: raise "No matching provider available"

  defp get_token!("google", code), do: Google.get_token!(code: code)
  defp get_token!(_, _), do: raise "No matching provider available"

  defp get_user!("google", token), do: OAuth2.AccessToken.get!(token, "https://www.googleapis.com/plus/v1/people/me/openIdConnect")
end
