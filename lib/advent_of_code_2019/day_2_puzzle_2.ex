defmodule AdventOfCode2019.Day2Puzzle2 do


  def process_input(noun, verb) do
    {:ok, input} = File.read("input/day-2-puzzle-1")

    input
    |> String.trim_trailing() # Trim, e.g. newline, character(s)
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> run(noun, verb)
  end


  def run(program, noun, verb) do
    program
    |> List.replace_at(1, noun)
    |> List.replace_at(2, verb)
    |> AdventOfCode2019.Day2Puzzle1.run()
    |> Enum.at(0)
  end


  def search() do
    {:ok, input} = File.read("input/day-2-puzzle-1")

    initial_program =
      input
      |> String.trim_trailing() # Trim, e.g. newline, character(s)
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    ( for i <- 0..99, j <- 0..99, do: {i, j} )
    |> Enum.find(fn {noun, verb} -> run(initial_program, noun, verb) == 19690720 end)
  end


  def output_answer() do
    {noun, verb} = search()
    (100 * noun) + verb
  end

end
