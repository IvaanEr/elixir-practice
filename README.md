# Phinx API

Basic CRUD API for Users with _name_, _email_, and _password_.

The _password_ is encrypted in the data store using [cloak_ecto](https://hexdocs.pm/cloak_ecto/readme.html).

The _password_ can only be retrieved with the a GET /users/{id}/hack, otherwise is
filtered by the user view.

## Start

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

## Test examples

```bash
  curl --request POST \
    --url http://localhost:4000/users \
    --header 'content-type: application/json' \
    --data '{
    "user": {
      "name": "Jhon Doe",
      "email": "jhon.doe@example.com",
      "password": "Alabama"
    }
  }'
```

```bash
  # Get all users
  curl --request GET \
    --url http://localhost:4000/users

  # Get user by id
  curl --request GET \
    --url http://localhost:4000/users/1

  # Hack user
  curl --request GET \
  --url http://localhost:4000/users/1/hack
```

```bash
  # Update user
  curl --request PUT \
    --url http://localhost:4000/users/1 \
    --header 'content-type: application/json' \
    --data '{
    "user": {
      "email": "nuevo@example.com",
      "name": "Juan Perez"
    }
  }'

  # Delete user
  curl --request DELETE \
    --url http://localhost:4000/users/1
```