defmodule BankPonchoTest do
  use ExUnit.Case
  doctest BankPoncho

  test "greets the world" do
    assert BankPoncho.hello() == :world
  end
end
