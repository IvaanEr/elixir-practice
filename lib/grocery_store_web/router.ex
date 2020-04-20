defmodule GroceryStoreWeb.Router do
  use GroceryStoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GroceryStoreWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/products", ProductController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GroceryStoreWeb do
  #   pipe_through :api
  # end
end
