defmodule AdventOfCode2019.Day2Puzzle2 do

  @type noun :: integer
  @type verb :: integer

  # Because `import` doesn't 'import' types:
  @type program :: AdventOfCode2019.Day2Puzzle1.program


  @spec process_input(noun, verb) :: program
  def process_input(noun, verb) do
    {:ok, input} = File.read("input/day-2-puzzle-1")

    input
    |> String.trim_trailing() # Trim, e.g. newline, character(s)
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> run(noun, verb)
  end


  # Because `import` doesn't 'import' types:
  @type value :: AdventOfCode2019.Day2Puzzle1.value


  @spec run(program, noun, verb) :: value
  def run(program, noun, verb) do
    {final_program, _outputs} =
      program
      |> List.replace_at(1, noun)
      |> List.replace_at(2, verb)
      |> AdventOfCode2019.Day2Puzzle1.run()

    hd(final_program)
  end


  @spec search() :: {noun, verb}
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


  @spec output_answer() :: integer
  def output_answer() do
    {noun, verb} = search()
    (100 * noun) + verb
  end

end
