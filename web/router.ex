defmodule Books.Router do
  use Books.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authorization do
    plug Books.Plugs.Authorization
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Books do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", Books do
    pipe_through [:browser, :authorization]

    resources "/users", UserController
    resources "/books", BookController
    resources "/borrowings", BorrowingController, only: [:index, :create]
  end

  scope "/auth", Books do
    pipe_through :browser # Use the default browser stack

    get "/:provider", AuthController, :index
    get "/:provider/callback", AuthController, :login
    delete "/", AuthController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", Books do
  #   pipe_through :api
  # end
end
