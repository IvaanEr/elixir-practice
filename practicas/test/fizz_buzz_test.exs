defmodule FizzBuzzTest do
  use ExUnit.Case
  doctest FizzBuzz

  test "FizzBuzz cond-do" do
    assert FizzBuzz.fuzzleCond(0, 0, "pepe") == "FizzBuzz"
    assert FizzBuzz.fuzzleCond(0, "pepa", "pepo") == "Fizz"
    assert FizzBuzz.fuzzleCond("pipo", 0, "xd") == "Buzz"
    assert FizzBuzz.fuzzleCond("123", "456", "8910") == "8910"
  end

  test "FizzBuzz case-do" do
    assert FizzBuzz.fuzzleCase(0, 0, "pepe") == "FizzBuzz"
    assert FizzBuzz.fuzzleCase(0, "pepa", "pepo") == "Fizz"
    assert FizzBuzz.fuzzleCase("pipo", 0, "xd") == "Buzz"
    assert FizzBuzz.fuzzleCase("123", "456", "8910") == "8910"
  end

  test "FizzBuzz pattern-matching" do
    assert FizzBuzz.fuzzle(0, 0, "pepe") == "FizzBuzz"
    assert FizzBuzz.fuzzle(0, "pepa", "pepo") == "Fizz"
    assert FizzBuzz.fuzzle("pipo", 0, "xd") == "Buzz"
    assert FizzBuzz.fuzzle("123", "456", "8910") == "8910"
  end
end
