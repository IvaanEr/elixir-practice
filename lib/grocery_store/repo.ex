defmodule GroceryStore.Repo do
  use Ecto.Repo,
    otp_app: :grocery_store,
    adapter: Ecto.Adapters.Postgres
end
