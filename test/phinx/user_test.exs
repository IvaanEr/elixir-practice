defmodule Phinx.PhinxTest do
  @moduledoc """
    Test user repo
  """
  use Phinx.DataCase
  alias Phinx.Users

  describe "users" do
    alias Phinx.Users.Schema.User

    @valid_attrs %{name: "John Doe", email: "john.doe@example.com", password: "1234"}
    @update_attrs %{name: "Jane Doe", email: "jane.doe@example.com"}
    @invalid_attrs %{name: nil, email: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create()
      user
    end

    test "list/0 returns all users" do
      user = user_fixture()
      assert Users.list() == [user]
    end

    test "get/1 returns the user by the given id" do
      user = user_fixture()
      assert Users.get(user.id) == {:ok, user}
    end

    test "create/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create(@valid_attrs)
      assert user.name == "John Doe"
      assert user.email == "john.doe@example.com"
      assert user.password == "1234"
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create(@invalid_attrs)
    end

    test "update/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update(user, @update_attrs)
      assert user.name == "Jane Doe"
      assert user.email == "jane.doe@example.com"
    end

    test "update/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update(user, @invalid_attrs)
      assert  Users.get(user.id) == {:ok, user}
    end

    test "delete/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete(user)
      assert {:error, :not_found} == Users.get(user.id)
    end
  end
end
