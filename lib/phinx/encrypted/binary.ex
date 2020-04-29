defmodule Phinx.Encrypted.Binary do
  use Cloak.Ecto.Binary, vault: Phinx.Vault
end
