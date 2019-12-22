defmodule AdventOfCode2019.Day2Puzzle2 do

  alias AdventOfCode2019.IntcodeComputerProgram

  @type noun :: integer
  @type verb :: integer

  # Because `import` doesn't 'import' types:
  @type program :: AdventOfCode2019.Day2Puzzle1.program
  @type value :: AdventOfCode2019.Day2Puzzle1.value


  @spec process_input(noun, verb) :: value
  def process_input(noun, verb) do
    {:ok, input} = File.read("input/day-2")

    input
    |> AdventOfCode2019.Day2Puzzle1.parse_program_string()
    |> run(noun, verb)
  end


  @spec run(program, noun, verb) :: value
  def run(program, noun, verb) do
    {:halted, final_program, _outputs} =
      program
      |> IntcodeComputerProgram.update_at(1, noun)
      |> IntcodeComputerProgram.update_at(2, verb)
      |> AdventOfCode2019.Day2Puzzle1.run()

    IntcodeComputerProgram.at(final_program, 0)
  end


  @spec search() :: {noun, verb}
  def search() do
    {:ok, input}    = File.read("input/day-2")
    initial_program = AdventOfCode2019.Day2Puzzle1.parse_program_string(input)

    ( for i <- 0..99, j <- 0..99, do: {i, j} )
    |> Enum.find(fn {noun, verb} -> run(initial_program, noun, verb) == 19690720 end)
  end


  @spec output_answer() :: integer
  def output_answer() do
    {noun, verb} = search()
    (100 * noun) + verb
  end

end
