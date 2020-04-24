defmodule PhinxWeb.PageController do
  use PhinxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
