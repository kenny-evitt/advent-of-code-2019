defmodule AdventOfCode2019.Day5Puzzle2Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  import AdventOfCode2019.Day2Puzzle1


  test "retrieve instruction parameters example 1" do
    program = [1002, 4, 3, 4, 33]
    instruction_pointer = 0
    expected_parameters = [33, 3, 4]

    {_opcode, [pm1, pm2, _]} =
      AdventOfCode2019.Day5Puzzle1.parse_instruction(
        Enum.at(program, instruction_pointer)
      )

    # Retrieve the third parameter as a pointer, i.e. as-if it was a regular 'immediate mode'
    # parameter:
    parameter_modes = [pm1, pm2, 1]

    actual_parameters = instruction_parameters(program, instruction_pointer, parameter_modes)
    assert actual_parameters == expected_parameters
  end



  test "opcode 8 example 1-1" do
    program = [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8]
    inputs = [1]
    expected_outputs = [0]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 8 example 1-2" do
    program = [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8]
    inputs = [8]
    expected_outputs = [1]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 8 example 1-3" do
    program = [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8]
    inputs = [11]
    expected_outputs = [0]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end


  test "opcode 8 example 2-1" do
    program = [3, 3, 1108, -1, 8, 3, 4, 3, 99]
    inputs = [1]
    expected_outputs = [0]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 8 example 2-2" do
    program = [3, 3, 1108, -1, 8, 3, 4, 3, 99]
    inputs = [8]
    expected_outputs = [1]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 8 example 2-3" do
    program = [3, 3, 1108, -1, 8, 3, 4, 3, 99]
    inputs = [11]
    expected_outputs = [0]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end



  test "opcode 7 example 1-1" do
    program = [3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8]
    inputs = [2]
    expected_outputs = [1]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 7 example 1-2" do
    program = [3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8]
    inputs = [8]
    expected_outputs = [0]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 7 example 1-3" do
    program = [3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8]
    inputs = [13]
    expected_outputs = [0]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end


  test "opcode 7 example 2-1" do
    program = [3, 3, 1107, -1, 8, 3, 4, 3, 99]
    inputs = [2]
    expected_outputs = [1]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 7 example 2-2" do
    program = [3, 3, 1107, -1, 8, 3, 4, 3, 99]
    inputs = [8]
    expected_outputs = [0]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 7 example 2-3" do
    program = [3, 3, 1107, -1, 8, 3, 4, 3, 99]
    inputs = [13]
    expected_outputs = [0]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end



  test "opcode 6 example 1-1" do
    program = [3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9]
    inputs = [0]
    expected_outputs = [0]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 6 example 1-2" do
    program = [3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9]
    inputs = [-19]
    expected_outputs = [1]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 6 example 1-3" do
    program = [3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9]
    inputs = [17]
    expected_outputs = [1]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end



  test "opcode 5 example 1-1" do
    program = [3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1]
    inputs = [0]
    expected_outputs = [0]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 5 example 1-2" do
    program = [3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1]
    inputs = [-19]
    expected_outputs = [1]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end

  test "opcode 5 example 1-3" do
    program = [3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1]
    inputs = [17]
    expected_outputs = [1]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end




  test "larger opcodes 5, 6, and 8 example 1-1" do
    program = [
      3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0,
      1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105,
      1, 46, 98, 99
    ]

    inputs = [6]
    expected_outputs = [999]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end


  test "larger opcodes 5, 6, and 8 example 1-2" do
    program = [
      3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0,
      1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105,
      1, 46, 98, 99
    ]

    inputs = [8]
    expected_outputs = [1000]
    {_, actual_outputs} = run(program, inputs)
    assert actual_outputs == expected_outputs
  end


  test "larger opcodes 5, 6, and 8 example 1-3" do
    program = [
      3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0,
      1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105,
      1, 46, 98, 99
    ]

    inputs = [29]
    expected_outputs = [1001]
    {_, actual_outputs} = run(program, inputs)
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


end
