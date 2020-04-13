defmodule EnumOperationsTest do
  use ExUnit.Case
  doctest EnumOperations

  test "greets the world" do
    assert EnumOperations.hello() == :world
  end
end
