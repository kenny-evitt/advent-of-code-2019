defmodule AdventOfCode2019.Day1Puzzle2Test do
  use ExUnit.Case
  import AdventOfCode2019.Day1Puzzle2

  test "example 1" do
    assert fuel_required(14) == 2
  end

  test "example 2" do
    assert fuel_required(1969) == 966
  end

  test "example 3" do
    assert fuel_required(100756) == 50346
  end
end
