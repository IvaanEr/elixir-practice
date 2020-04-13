defmodule ApiResponseTest do
  use ExUnit.Case
  doctest ApiResponse

  test "handle response" do
    assert ApiResponse.handle_response({:ok, "no importa"}) == "Ok"
    assert ApiResponse.handle_response({:error, "no importa"}) == "Error"
    assert ApiResponse.handle_response({:que_es_esto, "no importa"}) == :no_match_message_error
  end
  test "handle response 1" do
    assert ApiResponse.handle_response_1({:ok, "no importa"}) == "Ok"
    assert ApiResponse.handle_response_1({:error, "no importa"}) == "Error"
    assert ApiResponse.handle_response_1({:que_es_esto, "no importa"}) == :no_match_message_error
  end
  test "handle response 2" do
    assert ApiResponse.handle_response_2({:ok, "no importa"}) == "Ok"
    assert ApiResponse.handle_response_2({:error, "no importa"}) == "Error"
    assert ApiResponse.handle_response_2({:que_es_esto, "no importa"}) == :no_match_message_error
  end
end
