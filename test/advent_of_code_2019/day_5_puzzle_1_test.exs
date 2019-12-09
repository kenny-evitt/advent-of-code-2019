defmodule AdventOfCode2019.Day5Puzzle1Test do
  use ExUnit.Case
  use ExUnit.Parameterized


  test "opcode 3 example 1" do
    initial_program =
      [
        3, 50, 99, 0, 0, 0, 0, 0, 0, 0,
        0,  0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,  0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,  0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,  0,  0, 0, 0, 0, 0, 0, 0, 0,
        0
      ]

    input = 17
    inputs = [input]

    expected_final_program =
      [
        3,     50, 99, 0, 0, 0, 0, 0, 0, 0,
        0,      0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,      0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,      0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,      0,  0, 0, 0, 0, 0, 0, 0, 0,
        input
      ]

    {actual_final_program, _} = AdventOfCode2019.Day2Puzzle1.run(initial_program, inputs)
    assert actual_final_program == expected_final_program
  end


  test "opcode 4 example 1" do
    expected_output = 19

    initial_program =
      [
        4,               50, 99, 0, 0, 0, 0, 0, 0, 0,
        0,                0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,                0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,                0,  0, 0, 0, 0, 0, 0, 0, 0,
        0,                0,  0, 0, 0, 0, 0, 0, 0, 0,
        expected_output
      ]

    {_, actual_outputs} = AdventOfCode2019.Day2Puzzle1.run(initial_program)
    assert actual_outputs == [expected_output]
  end


end
