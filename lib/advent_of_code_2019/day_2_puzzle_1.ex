defmodule AdventOfCode2019.Day2Puzzle1 do

  @type value   :: integer
  @type program :: [value]

  @spec run(program) :: program
  def run(program) do
    run(program, 0)
  end

  @spec run(program, non_neg_integer) :: program
  defp run(program, current_opcode_index) do
    run(program, current_opcode_index, Enum.at(program, current_opcode_index))
  end

  @type opcode :: pos_integer



  @spec run(program, non_neg_integer, opcode) :: program
  defp run(program, current_opcode_index, opcode)


  defp run(program, _current_opcode_index, 99) do
    program
  end


  defp run(program, current_opcode_index, current_opcode) when current_opcode in [1, 2] do
    [arg1_index, arg2_index, result_index] =
      Enum.slice(program, current_opcode_index + 1, 3)

    arg1_value = Enum.at(program, arg1_index)
    arg2_value = Enum.at(program, arg2_index)

    computed_value =
      case current_opcode do
        1 -> arg1_value + arg2_value
        2 -> arg1_value * arg2_value
      end

    program
    |> List.replace_at(result_index, computed_value)
    |> run(current_opcode_index + 4)
  end


  defp run(_program, _current_opcode_index, _current_opcode) do
    raise("Encountered an unknown opcode; something went wrong.")
  end



  @spec process_input() :: value
  def process_input() do
    AdventOfCode2019.Day2Puzzle2.process_input(12, 2)
  end

end
