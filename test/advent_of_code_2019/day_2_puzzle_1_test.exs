defmodule AdventOfCode2019.Day2Puzzle1Test do
  use ExUnit.Case
  import AdventOfCode2019.Day2Puzzle1

  test "example 1" do
    initial_program        = [1,    9, 10, 3,  2, 3, 11, 0, 99, 30, 40, 50]
    expected_final_program = [3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50]
    {:halted, actual_final_program, _} = run(initial_program)
    assert actual_final_program == expected_final_program
  end

  test "example 2" do
    initial_program        = [1, 0, 0, 0, 99]
    expected_final_program = [2, 0, 0, 0, 99]
    {:halted, actual_final_program, _} = run(initial_program)
    assert actual_final_program == expected_final_program
  end

  test "example 3" do
    initial_program        = [2, 3, 0, 3, 99]
    expected_final_program = [2, 3, 0, 6, 99]
    {:halted, actual_final_program, _} = run(initial_program)
    assert actual_final_program == expected_final_program
  end

  test "example 4" do
    initial_program        = [2, 4, 4, 5, 99, 0   ]
    expected_final_program = [2, 4, 4, 5, 99, 9801]
    {:halted, actual_final_program, _} = run(initial_program)
    assert actual_final_program == expected_final_program
  end

  test "example 5" do
    initial_program        = [1,  1, 1, 4, 99, 5, 6, 0, 99]
    expected_final_program = [30, 1, 1, 4, 2,  5, 6, 0, 99]
    {:halted, actual_final_program, _} = run(initial_program)
    assert actual_final_program == expected_final_program
  end
end
