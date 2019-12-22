defmodule AdventOfCode2019.Day5Puzzle2Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  import AdventOfCode2019.Day2Puzzle1
  alias AdventOfCode2019.IntcodeComputerProgram


  test "retrieve instruction parameters example 1" do
    program_list = [1002, 4, 3, 4, 33]
    program = IntcodeComputerProgram.new(program_list)
    instruction_pointer = 0
    expected_parameters = [33, 3, 4]

    {_opcode, parameter_modes} =
      AdventOfCode2019.Day5Puzzle1.parse_instruction(
        IntcodeComputerProgram.at(program, instruction_pointer)
      )

    actual_parameters =
      instruction_parameters(
        program,
        instruction_pointer,
        [:input, :input, :output],
        parameter_modes,
        0
      )

    assert actual_parameters == expected_parameters
  end



  test "opcode 8 example 1-1" do
    program_list = [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [1]
    expected_outputs = [0]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 8 example 1-2" do
    program_list = [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [8]
    expected_outputs = [1]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 8 example 1-3" do
    program_list = [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [11]
    expected_outputs = [0]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end


  test "opcode 8 example 2-1" do
    program_list = [3, 3, 1108, -1, 8, 3, 4, 3, 99]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [1]
    expected_outputs = [0]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 8 example 2-2" do
    program_list = [3, 3, 1108, -1, 8, 3, 4, 3, 99]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [8]
    expected_outputs = [1]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 8 example 2-3" do
    program_list = [3, 3, 1108, -1, 8, 3, 4, 3, 99]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [11]
    expected_outputs = [0]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end



  test "opcode 7 example 1-1" do
    program_list = [3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [2]
    expected_outputs = [1]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 7 example 1-2" do
    program_list = [3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [8]
    expected_outputs = [0]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 7 example 1-3" do
    program_list = [3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [13]
    expected_outputs = [0]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end


  test "opcode 7 example 2-1" do
    program_list = [3, 3, 1107, -1, 8, 3, 4, 3, 99]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [2]
    expected_outputs = [1]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 7 example 2-2" do
    program_list = [3, 3, 1107, -1, 8, 3, 4, 3, 99]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [8]
    expected_outputs = [0]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 7 example 2-3" do
    program_list = [3, 3, 1107, -1, 8, 3, 4, 3, 99]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [13]
    expected_outputs = [0]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end



  test "opcode 6 example 1-1" do
    program_list = [3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [0]
    expected_outputs = [0]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 6 example 1-2" do
    program_list = [3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [-19]
    expected_outputs = [1]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 6 example 1-3" do
    program_list = [3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [17]
    expected_outputs = [1]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end



  test "opcode 5 example 1-1" do
    program_list = [3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [0]
    expected_outputs = [0]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 5 example 1-2" do
    program_list = [3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [-19]
    expected_outputs = [1]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 5 example 1-3" do
    program_list = [3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1]
    program = IntcodeComputerProgram.new(program_list)
    inputs = [17]
    expected_outputs = [1]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end




  test "larger opcodes 5, 6, and 8 example 1-1" do
    program_list = [
      3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0,
      1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105,
      1, 46, 98, 99
    ]

    program = IntcodeComputerProgram.new(program_list)
    inputs = [6]
    expected_outputs = [999]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end


  test "larger opcodes 5, 6, and 8 example 1-2" do
    program_list = [
      3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0,
      1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105,
      1, 46, 98, 99
    ]

    program = IntcodeComputerProgram.new(program_list)
    inputs = [8]
    expected_outputs = [1000]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end


  test "larger opcodes 5, 6, and 8 example 1-3" do
    program_list = [
      3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0,
      1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105,
      1, 46, 98, 99
    ]

    program = IntcodeComputerProgram.new(program_list)
    inputs = [29]
    expected_outputs = [1001]
    {:halted, _, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end




  # This results in a runtime exception:
  #
  # ```
  # ** (Protocol.UndefinedError) protocol Enumerable not implemented for 33 of type Integer. This protocol is implemented for the following type(s): HashSet, Range, Map, Function, List, Stream, Date.Range, HashDict, GenEvent.Stream, MapSet, File.Stream, IO.Stream
  #  code: test_with_params "retrieve instruction parameters",
  #  stacktrace:
  #    (elixir) lib/enum.ex:1: Enumerable.impl_for!/1
  #    (elixir) lib/enum.ex:193: Enumerable.slice/1
  #    (elixir) lib/enum.ex:3083: Enum.slice_any/3
  #    (elixir) lib/enum.ex:398: Enum.at/3
  #    test/advent_of_code_2019/day_5_puzzle_2_test.exs:26: anonymous fn/3 in AdventOfCode2019.Day5Puzzle2Test."test 'retrieve instruction parameters': number of 0"/1
  #    test/advent_of_code_2019/day_5_puzzle_2_test.exs:22: (test)
  # ```
  #
  _ = """
  test_with_params "retrieve instruction parameters",
    fn program, instruction_pointer, expected_parameters ->
      {_opcode, parameter_modes} =
        AdventOfCode2019.Day5Puzzle1.parse_instruction(
          Enum.at(program, instruction_pointer)
        )

      actual_parameters = instruction_parameters(program, instruction_pointer, parameter_modes)
      assert actual_parameters == expected_parameters
    end do
      [
        {[1002, 4, 3, 4, 33], 0, [33, 3, 4]}
      ]
  end
  """



  test "process input" do
    assert AdventOfCode2019.Day5Puzzle2.process_input() == 11189491
  end

end
