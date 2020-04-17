defmodule FizzBuzz do
  @moduledoc """
  Is this FizzBuzz? Or Fizz? mmm maybe just Buzz dude!
  """

  ## Make a fizz_buzz module and write a function called fuzzle that takes three arguments.
  ## If the first two are zero, return “FizzBuzz”. If the first is zero, return “Fizz”.
  ## If the second is zero return “Buzz”. Otherwise return the third argument.
  ## You don't need to use recursion here, create 2 methods, one using cond do,
  ## and the other one case do.

  @doc """
    fuzzle with patter-matching
  """
  def fuzzle(0, 0, _), do: "FizzBuzz"
  def fuzzle(0, _, _), do: "Fizz"
  def fuzzle(_, 0, _), do: "Buzz"
  def fuzzle(_, _, n), do: n

  @doc """
    fuzzle with cond-do
  """
  def fuzzleCond(a, b, c) do
    cond do
      a == 0 and b == 0 -> "FizzBuzz"
      a == 0 -> "Fizz"
      b == 0 -> "Buzz"
      true -> c
    end
  end

  @doc """
    fuzzle with case-do
  """
  def fuzzleCase(a, b, c) do
    case {a, b, c} do
      {0, 0, _} -> "FizzBuzz"
      {0, _, _} -> "Fizz"
      {_, 0, _} -> "Buzz"
      {_, _, c} -> c
    end
  end
end
