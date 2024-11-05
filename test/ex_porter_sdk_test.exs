defmodule ExPorterSdkTest do
  use ExUnit.Case
  doctest ExPorterSdk

  test "greets the world" do
    assert ExPorterSdk.hello() == :world
  end
end
