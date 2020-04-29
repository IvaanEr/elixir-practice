defmodule PhinxWeb.UserController do
  @moduledoc """
    User controller
  """
  use PhinxWeb, :controller

  alias Phinx.Users

  plug :authenticate

  def index(conn, _params) do
    users = Users.list()
    conn
    |> render("index.json", users: users)
  end

  def show(conn, %{"id" => user_id}) do
    with {:ok, user} <- Users.get(user_id) do
      conn
      |> render("user.json", user: user)
    end

  end

  def create(conn, %{"user" => attrs}) do
    with {:ok, new_user} <- Users.create(attrs) do
      conn
      |> put_status(:created)
      |> render("user.json", user: new_user)
    end
  end

  def update(conn, %{"id" => user_id, "user" => attrs}) do
    with  {:ok, old_user} <- Users.get(user_id),
          {:ok, new_user} <- Users.update(old_user, attrs) do
            conn
            |> put_status(:created)
            |> render("user.json", user: new_user)
    end
  end

  def delete(conn, %{"id" => user_id}) do
    with  {:ok, user} <- Users.get(user_id),
          {:ok, _} <- Users.delete(user) do
      conn
      |> send_resp(:no_content, "")
    end
  end

  def hack(conn, %{"id" => user_id}) do
    with {:ok, user} <- Users.get(user_id) do
      conn
      |> render("hack.json", user: user)
    end
  end

  defp authenticate(conn, _opts) do
    tokens = conn
    |> Plug.Conn.get_req_header("x-phinx-token")

    if Enum.member?(tokens, System.get_env("HARDCODED_TOKEN")) do
      conn
    else
      conn
      |> send_resp(:unauthorized, "")
    end

  end

end
