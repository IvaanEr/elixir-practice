defmodule PhinxWeb.UserView do
  @moduledoc """
    User view
  """
  use PhinxWeb, :view

  alias PhinxWeb.UserView

  @doc """
    Render a list of users
  """
  def render("index.json", %{users: users}) do
    render_many(users, UserView, "user.json")
  end

  @doc """
    Render one user
  """
  def render("user.json", %{user: user}) do
    %{user_id: user.id, name: user.name, email: user.email}
  end

  @doc """
    Ups! Render the user password
  """
  def render("hack.json", %{user: user}) do
    %{email: user.email, password: user.password}
  end
end
