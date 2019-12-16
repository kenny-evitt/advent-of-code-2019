defmodule AdventOfCode2019.Day5Puzzle1 do

  @type value  :: AdventOfCode2019.Day2Puzzle1.value
  @type opcode :: AdventOfCode2019.Day2Puzzle1.opcode

  @type digit          :: 0..9
  @type digits         :: [digit]
  @type parameter_mode :: 0 | 1


  @spec parse_instruction(value | digits) :: {opcode, [parameter_mode]}
  def parse_instruction(value_or_digits)

  def parse_instruction(value) when not is_list(value) do
    parse_instruction(
      Integer.digits(value)
    )
  end

  def parse_instruction([digit]),                 do: {digit,          [0,   0,   0  ]}
  def parse_instruction([d1, d2]),                do: {(d1 * 10) + d2, [0,   0,   0  ]}
  def parse_instruction([pm1, d1, d2]),           do: {(d1 * 10) + d2, [pm1, 0,   0  ]}
  def parse_instruction([pm2, pm1, d1, d2]),      do: {(d1 * 10) + d2, [pm1, pm2, 0  ]}
  def parse_instruction([pm3, pm2, pm1, d1, d2]), do: {(d1 * 10) + d2, [pm1, pm2, pm3]}


  @type program :: AdventOfCode2019.Day2Puzzle1.program
  @type output  :: AdventOfCode2019.Day2Puzzle1.output
  @type outputs :: AdventOfCode2019.Day2Puzzle1.outputs


  @spec process_input() :: output | {:error, String.t, program, outputs}
  def process_input() do
    {:ok, input}    = File.read("input/day-5-puzzle-1")
    initial_program = AdventOfCode2019.Day2Puzzle1.parse_program_string(input)
    inputs          = [1]

    {final_program, outputs} =
      AdventOfCode2019.Day2Puzzle1.run(initial_program, inputs)

    test_results = Enum.drop(outputs, -1)

    all_tests_passed =
      Enum.map(test_results, &(&1 == 0))
      |> Enum.all?()

    if not all_tests_passed do
      {:error, "Not all tests passed!", final_program, outputs}
    else
      List.last(outputs) # Diagnostic code
    end
  end


end
