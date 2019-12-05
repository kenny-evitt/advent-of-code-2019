defmodule AdventOfCode2019.Day2Puzzle1Test do
  use ExUnit.Case
  import AdventOfCode2019.Day2Puzzle1

  test "example 1" do
    program_initial = [1,    9, 10, 3,  2, 3, 11, 0, 99, 30, 40, 50]
    program_final   = [3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50]
    assert run(program_initial) == program_final
  end

  test "example 2" do
    program_initial = [1, 0, 0, 0, 99]
    program_final   = [2, 0, 0, 0, 99]
    assert run(program_initial) == program_final
  end

  test "example 3" do
    program_initial = [2, 3, 0, 3, 99]
    program_final   = [2, 3, 0, 6, 99]
    assert run(program_initial) == program_final
  end

  test "example 4" do
    program_initial = [2, 4, 4, 5, 99, 0   ]
    program_final   = [2, 4, 4, 5, 99, 9801]
    assert run(program_initial) == program_final
  end

  test "example 5" do
    program_initial = [1,  1, 1, 4, 99, 5, 6, 0, 99]
    program_final   = [30, 1, 1, 4, 2,  5, 6, 0, 99]
    assert run(program_initial) == program_final
  end
end
