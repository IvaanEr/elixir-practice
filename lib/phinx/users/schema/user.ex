defmodule Phinx.Users.Schema.User do
  @moduledoc """
    User Schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :name, :string
    field :email, :string
    field :password, Phinx.Encrypted.Binary
    timestamps()
  end

  def changeset(struct, fields) do
    struct
    |> cast(fields, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
  end

end
