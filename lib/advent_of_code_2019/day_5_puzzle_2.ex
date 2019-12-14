defmodule AdventOfCode2019.Day5Puzzle2 do


  def process_input() do
    {:ok, input} = File.read("input/day-5-puzzle-1")

    initial_program =
      input
      |> String.trim_trailing() # Trim, e.g. newline, character(s)
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    inputs = [5]

    {_final_program, [diagnostic_code]} =
      AdventOfCode2019.Day2Puzzle1.run(initial_program, inputs)

    diagnostic_code
  end


end
