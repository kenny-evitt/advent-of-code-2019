defmodule AdventOfCode2019.Day2Puzzle1Test do
  use ExUnit.Case
  import AdventOfCode2019.Day2Puzzle1
  alias AdventOfCode2019.IntcodeComputerProgram

  test "example 1" do
    initial_program_list        = [1,    9, 10, 3,  2, 3, 11, 0, 99, 30, 40, 50]
    expected_final_program_list = [3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50]
    initial_program = IntcodeComputerProgram.new(initial_program_list)
    {:halted, actual_final_program, _} = run(initial_program)
    actual_final_program_list = IntcodeComputerProgram.to_list(actual_final_program)
    assert actual_final_program_list == expected_final_program_list
  end

  test "example 2" do
    initial_program_list        = [1, 0, 0, 0, 99]
    expected_final_program_list = [2, 0, 0, 0, 99]
    initial_program = IntcodeComputerProgram.new(initial_program_list)
    {:halted, actual_final_program, _} = run(initial_program)
    actual_final_program_list = IntcodeComputerProgram.to_list(actual_final_program)
    assert actual_final_program_list == expected_final_program_list
  end

  test "example 3" do
    initial_program_list        = [2, 3, 0, 3, 99]
    expected_final_program_list = [2, 3, 0, 6, 99]
    initial_program = IntcodeComputerProgram.new(initial_program_list)
    {:halted, actual_final_program, _} = run(initial_program)
    actual_final_program_list = IntcodeComputerProgram.to_list(actual_final_program)
    assert actual_final_program_list == expected_final_program_list
  end

  test "example 4" do
    initial_program_list        = [2, 4, 4, 5, 99, 0   ]
    expected_final_program_list = [2, 4, 4, 5, 99, 9801]
    initial_program = IntcodeComputerProgram.new(initial_program_list)
    {:halted, actual_final_program, _} = run(initial_program)
    actual_final_program_list = IntcodeComputerProgram.to_list(actual_final_program)
    assert actual_final_program_list == expected_final_program_list
  end

  test "example 5" do
    initial_program_list        = [1,  1, 1, 4, 99, 5, 6, 0, 99]
    expected_final_program_list = [30, 1, 1, 4, 2,  5, 6, 0, 99]
    initial_program = IntcodeComputerProgram.new(initial_program_list)
    {:halted, actual_final_program, _} = run(initial_program)
    actual_final_program_list = IntcodeComputerProgram.to_list(actual_final_program)
    assert actual_final_program_list == expected_final_program_list
  end

  test "process input" do
    assert process_input() == 5110675
  end

end
