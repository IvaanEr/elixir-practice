defmodule Phinx.Users do
  @moduledoc """
    User Context
  """
  alias Phinx.Users.Schema.User
  alias Phinx.Repo

  def list do
    User
    |> Repo.all()
  end

  def get(id) do
    case user = Repo.get(User, id) do
      %User{} -> {:ok, user}
      nil -> {:error, :not_found}
    end
  end

  def create(attrs) do
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()
  end

  def update(%User{} = user, attrs) do
      user
      |> User.changeset(attrs)
      |> Repo.update()
  end

  def delete(user) do
    user
    |> Repo.delete()
  end
end
