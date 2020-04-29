defmodule PhinxWeb.FallbackController do
  @moduledoc """
  Fallback controller.
  Called when other controllers failed to return a %Plug.Conn{}
  """
  use PhinxWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = _changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(PhinxWeb.ErrorView)
    |> render(:"422")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(PhinxWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PhinxWeb.ErrorView)
    |> render(:"400")
  end

  def call(conn, {:error, :forbidden}) do
    conn
    |> put_status(:forbidden)
    |> put_view(PhinxWeb.ErrorView)
    |> render(:"403")
  end

  def call(conn, {:error, :service_unavailable}) do
    conn
    |> put_status(:service_unavailable)
    |> put_view(PhinxWeb.ErrorView)
    |> render(:"503")
  end

  def call(conn, :ok) do
    conn
    |> send_resp(:no_content, "")
  end

  def call(_conn, error) do
    IO.puts "NEW ERROR"
    IO.inspect(error)
  end

end
