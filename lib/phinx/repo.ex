defmodule Phinx.Repo do
  use Ecto.Repo,
    otp_app: :phinx,
    adapter: Ecto.Adapters.Postgres
end
