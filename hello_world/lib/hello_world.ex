defmodule HelloWorld do
  @moduledoc """
  `HelloWorld` is just the beginning of a great adventure with Elixir!
  """

  @doc """
  Says hello to the world!

  ## Examples
      iex> HelloWorld.hello()
      "Hello World!"

  """
  def hello do
    "Hello World!"
  end

  @doc """
  Says goodbye, terminator style.

  ## Examples
      iex> HelloWorld.goodbye()
      "Hasta la vista, baby!"
  """
  def goodbye do
    "Hasta la vista, baby!"
  end
  def sum(a,b) do
   a + b
  end
end
