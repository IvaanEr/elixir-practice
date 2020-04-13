defmodule EnumOperations do
  @moduledoc """
  `EnumOperations` implements some operations from the Enum module just for `lists`
  """

  @doc """
  Return the size of the list
  """
  @spec count([any]) :: non_neg_integer
  def count([]), do: 0
  def count([_n|tail]), do: 1 + count(tail)


  @doc """
  Return the list in reverse order
  """
  def reverse(list), do: doReverse(list, [])

  defp doReverse([], acumm), do: acumm
  defp doReverse([x|xs], acumm), do: doReverse(xs, acumm) ++ [x|acumm]

  @doc """
  Return the list of elements that satisfy the given predicate
  """
  def filter([], _filtro), do: []
  def filter([x|xs], filtro) do
    case filtro.(x) do
      true -> [x | filter(xs, filtro)]
      false -> filter xs, filtro
    end
  end

  @doc """
  Given a list of lists, concatenates the lists into a single list
  """
  def concat([]), do: []
  def concat([[]|ys]), do: concat ys
  def concat([[x|xs]|yss]), do: [x | concat [xs|yss]]

end
