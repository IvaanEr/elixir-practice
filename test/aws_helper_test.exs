defmodule AwsHelperTest do
  use ExUnit.Case
  doctest AwsHelper

  test "greets the world" do
    assert AwsHelper.hello() == :world
  end
end
