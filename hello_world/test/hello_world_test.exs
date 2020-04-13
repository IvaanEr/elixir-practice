defmodule HelloWorldTest do
  use ExUnit.Case
  doctest HelloWorld

  test "greets the world" do
    assert HelloWorld.hello() == "Hello World!"
  end

  test "goodby the world" do
    assert HelloWorld.goodbye() == "Hasta la vista, baby!"
  end
end
