defmodule AdventOfCode2019.Day5Puzzle2 do


  def process_input() do
    {:ok, input}    = File.read("input/day-5-puzzle-1")
    initial_program = AdventOfCode2019.Day2Puzzle1.parse_program_string(input)
    inputs          = [5]

    {:halted, _final_program, [diagnostic_code]} =
      AdventOfCode2019.Day2Puzzle1.run(initial_program, inputs)

    diagnostic_code
  end


end
