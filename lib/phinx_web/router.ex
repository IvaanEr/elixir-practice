defmodule PhinxWeb.Router do
  use PhinxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhinxWeb do
    pipe_through :api
  end
end
