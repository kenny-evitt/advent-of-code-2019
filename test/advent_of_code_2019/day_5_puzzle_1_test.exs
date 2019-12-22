defmodule AdventOfCode2019.Day5Puzzle1Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  import AdventOfCode2019.Day5Puzzle1
  alias AdventOfCode2019.IntcodeComputerProgram


  test "opcode 3 example 1" do
    initial_program_list =
      [
        3, 50, 99, 0, 0, 0, 0, 0, 0, 0,
        0,  0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,  0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,  0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,  0,  0, 0, 0, 0, 0, 0, 0, 0,
        0
      ]

    initial_program = IntcodeComputerProgram.new(initial_program_list)
    input = 17
    inputs = [input]

    expected_final_program_list =
      [
        3,     50, 99, 0, 0, 0, 0, 0, 0, 0,
        0,      0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,      0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,      0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,      0,  0, 0, 0, 0, 0, 0, 0, 0,
        input
      ]

    {:halted, actual_final_program, _} = AdventOfCode2019.Day2Puzzle1.run(initial_program, inputs)
    actual_final_program_list = IntcodeComputerProgram.to_list(actual_final_program)
    assert actual_final_program_list == expected_final_program_list
  end


  test "opcode 4 example 1" do
    expected_output = 19

    initial_program_list =
      [
        4,               50, 99, 0, 0, 0, 0, 0, 0, 0,
        0,                0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,                0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,                0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,                0,  0, 0, 0, 0, 0, 0, 0, 0,
        expected_output
      ]

    initial_program = IntcodeComputerProgram.new(initial_program_list)
    {:halted, _, actual_outputs} = AdventOfCode2019.Day2Puzzle1.run(initial_program)
    assert actual_outputs == [expected_output]
  end


  test "opcode 3 and 4 example 1" do
    initial_program_list = [3, 0, 4, 0, 99]
    initial_program = IntcodeComputerProgram.new(initial_program_list)
    input = 23
    inputs = [input]
    expected_final_program_list = [input, 0, 4, 0, 99]
    expected_final_program = IntcodeComputerProgram.new(expected_final_program_list)
    expected_outputs = inputs
    expected = {:halted, expected_final_program, expected_outputs}
    assert AdventOfCode2019.Day2Puzzle1.run(initial_program, inputs) == expected
  end

  test_with_params "parse instructions",
    fn instruction, expected_parsing ->
      assert parse_instruction(instruction) == expected_parsing
    end do
      [
        {    2, {2, [0, 0, 0]}},
        { 1002, {2, [0, 1, 0]}},
        {11102, {2, [1, 1, 1]}}
      ]
  end

  test "parameter modes example 1" do
    initial_program_list =        [1002, 4, 3, 4, 33, 99]
    expected_final_program_list = [1002, 4, 3, 4, 99, 99]
    initial_program = IntcodeComputerProgram.new(initial_program_list)
    {:halted, actual_final_program, _} = AdventOfCode2019.Day2Puzzle1.run(initial_program)
    actual_final_program_list = IntcodeComputerProgram.to_list(actual_final_program)
    assert actual_final_program_list == expected_final_program_list
  end

  test "parameter modes example 2" do
    initial_program_list =        [1002, 4, 3, 4, 33]
    expected_final_program_list = [1002, 4, 3, 4, 99]
    initial_program = IntcodeComputerProgram.new(initial_program_list)
    {:halted, actual_final_program, _} = AdventOfCode2019.Day2Puzzle1.run(initial_program)
    actual_final_program_list = IntcodeComputerProgram.to_list(actual_final_program)
    assert actual_final_program_list == expected_final_program_list
  end

  test "parameter modes example 3" do
    initial_program_list =        [1101, 100, -1, 4,  0]
    expected_final_program_list = [1101, 100, -1, 4, 99]
    initial_program = IntcodeComputerProgram.new(initial_program_list)
    {:halted, actual_final_program, _} = AdventOfCode2019.Day2Puzzle1.run(initial_program)
    actual_final_program_list = IntcodeComputerProgram.to_list(actual_final_program)
    assert actual_final_program_list == expected_final_program_list
  end

  test "process input" do
    assert process_input() == 13978427
  end

end
