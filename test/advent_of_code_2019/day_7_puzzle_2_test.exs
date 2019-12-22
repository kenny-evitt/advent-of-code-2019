defmodule AdventOfCode2019.Day7Puzzle2Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  import AdventOfCode2019.Day7Puzzle2

  test "program halts for input instruction and no inputs" do
    program_string = "3,3,99,0"
    program = AdventOfCode2019.Day2Puzzle1.parse_program_string(program_string)
    assert AdventOfCode2019.Day2Puzzle1.run(program, []) == {:waiting_for_input, program, 0, [], 0}
  end

  test_with_params "run amplifiers",
    fn program_string, phase_settings, expected_output ->
      program = AdventOfCode2019.Day2Puzzle1.parse_program_string(program_string)
      {_amplifiers, [actual_output]} = run_amplifiers(program, phase_settings)
      assert actual_output == expected_output
    end do
      [
        {
          "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5",
          [9, 8, 7, 6, 5],
          139629729
        },
        {
          "3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10",
          [9, 7, 8, 5, 6],
          18216
        }
      ]
  end

  test_with_params "find amplifiers phase settings with max output",
    fn program_string, expected_phase_settings, expected_max_output ->
      program = AdventOfCode2019.Day2Puzzle1.parse_program_string(program_string)
      actual_result = find_phase_settings_with_max_output(program)
      assert actual_result == {expected_phase_settings, expected_max_output}
    end do
      [
        {
          "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5",
          [9, 8, 7, 6, 5],
          139629729
        },
        {
          "3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10",
          [9, 7, 8, 5, 6],
          18216
        }
      ]
  end

  test "process input" do
    assert process_input() == 17519904
  end

end
