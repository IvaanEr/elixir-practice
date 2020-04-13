defmodule EnumOperationsTest do
  import Integer
  use ExUnit.Case
  doctest EnumOperations

  test "count" do
    assert EnumOperations.count([1, 2, 3]) == 3
    assert EnumOperations.count([]) == 0
  end

  test "reverse" do
    assert EnumOperations.reverse([]) == []
    assert EnumOperations.reverse([1, 2, 3]) == [3, 2, 1]
  end

  test "filter" do
    assert EnumOperations.filter([], fn x -> Integer.is_even(x) end) == []
    assert EnumOperations.filter([1, 2, 3, 4], fn x -> Integer.is_even(x) end) == [2, 4]
  end

  test "concat" do
    assert EnumOperations.concat([]) == []
    assert EnumOperations.concat([[1, 2]]) == [1, 2]
    assert EnumOperations.concat([[1, 2, 3], [4, 5, 6]]) == [1, 2, 3, 4, 5, 6]
  end
end
