defmodule AdventOfCode2019.Day1Puzzle1Test do
  use ExUnit.Case
  import AdventOfCode2019.Day1Puzzle1

  test "example 1" do
    assert module_fuel_required(12) == 2
  end

  test "example 2" do
    assert module_fuel_required(14) == 2
  end

  test "example 3" do
    assert module_fuel_required(1969) == 654
  end

  test "example 4" do
    assert module_fuel_required(100756) == 33583
  end
end
