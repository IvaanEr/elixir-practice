defmodule ApiResponse do
@moduledoc """
  Handle a response by the first value of the tuple
"""

#Make a api_response module, it will receive an tuple, the first item will be an
#atom (:ok and :error) and the other one will be a map (we don't need to care about
#the second item). The idea is very similar to the previous one, we need to create
#4 function (if and else, cond, case, functions ) that returns the same response,
#for example:
#ApiResponse.handle_response_1({:ok, %{blabla}}) ->"Ok"
#ApiResponse.handle_response_1({:error, %{blabla}}) ->"Error"
#ApiResponse.handle_response_1({:what, %{blabla}}) -> :no_match_message_error

@doc """
  Handle response
"""
def handle_response({:ok, _}), do: "Ok"
def handle_response({:error, _}), do: "Error"
def handle_response({_, _}), do: :no_match_message_error

@doc """
  Handle response 1
"""
def handle_response_1(response) do
  case response do
    {:ok, _} -> "Ok"
    {:error, _} -> "Error"
    {_, _} -> :no_match_message_error
  end
end

@doc """
  Handle response 2
"""
def handle_response_2({status, _data}) do
  cond do
    status == :ok    -> "Ok"
    status == :error -> "Error"
    true             -> :no_match_message_error
  end
end

end
