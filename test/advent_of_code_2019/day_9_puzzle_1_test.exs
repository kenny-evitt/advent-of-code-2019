defmodule AdventOfCode2019.Day9Puzzle1Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  alias AdventOfCode2019.IntcodeComputerProgram


  test "instruction parameters are the same for relative and position mode when the relative base is 0" do
    program_list =
      [
        0, 0, 0,  0, 0, 0, 0, 0, 0, 0,
        0, 0, 0,  0, 0, 0, 0, 0, 0, 0,
        0, 0, 0,  0, 0, 0, 0, 0, 0, 0,
        0, 0, 0,  0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 33, 0, 0, 0, 0, 0, 0,
      ]

    program = IntcodeComputerProgram.new(program_list)
    relative_base = 0
    parameter = 43

    parameter_position_mode =
      AdventOfCode2019.Day2Puzzle1.instruction_parameter(
        program,
        parameter,
        :input,
        0,
        relative_base
      )

    parameter_relative_mode =
      AdventOfCode2019.Day2Puzzle1.instruction_parameter(
        program,
        parameter,
        :input,
        2,
        relative_base
      )

    assert parameter_position_mode == parameter_relative_mode
  end


  test "instruction parameter for relative mode" do
    expected_parameter = 33

    program_list =
      [
        0, 0, 0,                     0, 0, 0, 0, 0, 0, 0,
        0, 0, 0,                     0, 0, 0, 0, 0, 0, 0,
        0, 0, 0,                     0, 0, 0, 0, 0, 0, 0,
        0, 0, 0,                     0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, expected_parameter, 0, 0, 0, 0, 0, 0, 0,
        0
      ]

    program = IntcodeComputerProgram.new(program_list)
    relative_base = 50
    parameter = -7

    actual_parameter =
      AdventOfCode2019.Day2Puzzle1.instruction_parameter(
        program,
        parameter,
        :input,
        2,
        relative_base
      )

    assert actual_parameter == expected_parameter
  end


  test "can parse instruction `109`" do
    assert AdventOfCode2019.Day5Puzzle1.parse_instruction(109) == {9, [1, 0, 0]}
  end


  test "can execute opcode 9" do
    output_value = 47

    program_list =
      [
        109, 2000, 109, 19, 204,          -34, 99, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0,            0,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0,    0,   0,  0,   0, output_value,  0, 0, 0, 0,     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

          0
      ]

    program = IntcodeComputerProgram.new(program_list)
    {:halted, _program, outputs} = AdventOfCode2019.Day2Puzzle1.run(program)

    assert outputs == [output_value]
  end


  test "new Intcode computer features example 1" do
    program = 
      "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99"
      |> AdventOfCode2019.Day2Puzzle1.parse_program_string()

    program_list = IntcodeComputerProgram.to_list(program)

    {:halted, _, outputs} = AdventOfCode2019.Day2Puzzle1.run(program)

    assert outputs == program_list
  end


  test "new Intcode computer features example 2" do
    {:halted, _, [output]} =
      "1102,34915192,34915192,7,4,7,99,0"
      |> AdventOfCode2019.Day2Puzzle1.parse_program_string()
      |> AdventOfCode2019.Day2Puzzle1.run()

    assert length(Integer.digits(output)) == 16
  end


  test "new Intcode computer features example 3" do
    program = 
      "104,1125899906842624,99"
      |> AdventOfCode2019.Day2Puzzle1.parse_program_string()

    expected_output = IntcodeComputerProgram.at(program, 1)
    {:halted, _, [output]} = AdventOfCode2019.Day2Puzzle1.run(program)
    assert output == expected_output
  end


  test "BOOST runs" do
    assert AdventOfCode2019.Day9Puzzle1.process_input()
  end

  test "BOOST keycode is correct" do
    assert AdventOfCode2019.Day9Puzzle1.process_input() == 2955820355
  end

end
