defmodule BankPersistenceTest do
  use ExUnit.Case
  doctest BankPersistence

  test "greets the world" do
    assert BankPersistence.hello() == :world
  end
end
