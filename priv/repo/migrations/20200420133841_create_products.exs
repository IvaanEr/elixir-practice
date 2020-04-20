defmodule GroceryStore.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :description, :string
      add :price, :integer
      add :stock, :integer

      timestamps()
    end

  end
end
