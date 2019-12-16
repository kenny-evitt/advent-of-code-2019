defmodule AdventOfCode2019.Day7Puzzle1Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  import AdventOfCode2019.Day7Puzzle1

  test_with_params "run amplifiers",
    fn program_string, phase_settings, expected_output ->
      program = AdventOfCode2019.Day2Puzzle1.parse_program_string(program_string)
      assert run_amplifiers(program, phase_settings) == expected_output
    end do
      [
        {
          "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0",
          [4, 3, 2, 1, 0],
          43210
        },
        {
          "3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0",
          [0, 1, 2, 3, 4],
          54321
        },
        {
          "3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0",
          [1, 0, 4, 3, 2],
          65210
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
          "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0",
          [4, 3, 2, 1, 0],
          43210
        },
        {
          "3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0",
          [0, 1, 2, 3, 4],
          54321
        },
        {
          "3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0",
          [1, 0, 4, 3, 2],
          65210
        }
      ]
  end

end
