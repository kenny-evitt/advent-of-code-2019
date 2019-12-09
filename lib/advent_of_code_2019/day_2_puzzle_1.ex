defmodule AdventOfCode2019.Day2Puzzle1 do

  @type value   :: integer
  @type program :: [value]
  @type input   :: integer
  @type inputs  :: [input]
  @type output  :: integer
  @type outputs :: [output]

  @spec run(program, inputs) :: {program, outputs}
  def run(program, inputs \\ []) do
    run(program, inputs, [], 0)
  end


  @spec run(program, inputs, outputs, non_neg_integer) :: {program, outputs}
  defp run(program, inputs, outputs, current_opcode_index) do
    {opcode, parameter_modes} =
      AdventOfCode2019.Day5Puzzle1.parse_instruction(
        Enum.at(program, current_opcode_index)
      )

    run(
      program,
      inputs,
      outputs,
      current_opcode_index,
      opcode,
      parameter_modes
    )
  end


  @type opcode :: pos_integer

  @type parameter_mode :: AdventOfCode2019.Day5Puzzle1.parameter_mode



  @spec run(program, inputs, outputs, non_neg_integer, opcode, [parameter_mode]) :: {program, outputs}
  defp run(program, inputs, outputs, current_opcode_index, opcode, parameter_modes)


  # Opcode
  #
  #  - 99   Halt
  #
  defp run(program, _inputs, outputs, _current_opcode_index, 99, _parameter_modes) do
    {
      program,
      Enum.reverse(outputs)
    }
  end


  # Opcodes
  #
  #  -  1   Add
  #  -  2   Multiply
  #
  defp run(program, inputs, outputs, current_opcode_index, current_opcode, parameter_modes)
  when current_opcode in [1, 2] do
    [arg1_mode, arg2_mode, _] = parameter_modes

    [arg1_index_or_value, arg2_index_or_value, result_index] =
      Enum.slice(program, current_opcode_index + 1, 3)

    arg1_value =
      case arg1_mode do
        0 -> Enum.at(program, arg1_index_or_value)
        1 -> arg1_index_or_value
      end

    arg2_value =
      case arg2_mode do
        0 -> Enum.at(program, arg2_index_or_value)
        1 -> arg2_index_or_value
      end

    computed_value =
      case current_opcode do
        1 -> arg1_value + arg2_value
        2 -> arg1_value * arg2_value
      end

    program
    |> List.replace_at(result_index, computed_value)
    |> run(
      inputs,
      outputs,
      current_opcode_index + 4
    )
  end


  # Opcode
  #
  #  -  3   Input
  #
  defp run(program, [input | inputs_tail], outputs, current_opcode_index, 3, _parameter_modes) do
    result_index = Enum.at(program, current_opcode_index + 1)

    program
    |> List.replace_at(result_index, input)
    |> run(
      inputs_tail,
      outputs,
      current_opcode_index + 2
    )
  end


  # Opcode
  #
  #  -  4   Output
  #
  defp run(program, inputs, outputs, current_opcode_index, 4, parameter_modes) do
    [arg_mode, _, _] = parameter_modes
    arg_index_or_value = Enum.at(program, current_opcode_index + 1)

    arg_value =
      case arg_mode do
        0 -> Enum.at(program, arg_index_or_value)
        1 -> arg_index_or_value
      end

    run(
      program,
      inputs,
      [arg_value | outputs],
      current_opcode_index + 2
    )
  end


  defp run(_program, _inputs, _outputs, _current_opcode_index, _current_opcode, _parameter_modes) do
    raise("Encountered an unknown opcode; something went wrong.")
  end



  @spec process_input() :: value
  def process_input() do
    AdventOfCode2019.Day2Puzzle2.process_input(12, 2)
  end

end
