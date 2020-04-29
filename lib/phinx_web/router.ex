defmodule PhinxWeb.Router do
  use PhinxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhinxWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    get "/users/:id/hack", UserController, :hack
  end
end
