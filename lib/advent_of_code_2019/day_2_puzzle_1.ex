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

  @type pointer :: non_neg_integer


  @spec run(program, inputs, outputs, pointer) :: {program, outputs}
  defp run(program, inputs, outputs, current_instruction_pointer) do
    {opcode, parameter_modes} =
      AdventOfCode2019.Day5Puzzle1.parse_instruction(
        Enum.at(program, current_instruction_pointer)
      )

    run(
      program,
      inputs,
      outputs,
      current_instruction_pointer,
      opcode,
      parameter_modes
    )
  end


  @type opcode :: pos_integer

  @type parameter_mode :: AdventOfCode2019.Day5Puzzle1.parameter_mode


  @spec instruction_parameter(program, value, parameter_mode) :: value
  def instruction_parameter(program, parameter_pointer_or_value, parameter_mode)

  def instruction_parameter(program,  pointer, 0), do: Enum.at(program, pointer)
  def instruction_parameter(_program, value,   1), do: value


  @spec instruction_parameters(program, pointer, [parameter_mode]) :: [value]
  def instruction_parameters(program, instruction_pointer, parameter_modes) do
    Enum.zip(
      Enum.slice(
        program,
        instruction_pointer + 1,
        length(parameter_modes)
      ),
      parameter_modes
    )
    |> Enum.map(
      fn {pointer_or_value, parameter_mode} ->
        instruction_parameter(program, pointer_or_value, parameter_mode)
      end
    )
  end




  @spec run(program, inputs, outputs, pointer, opcode, [parameter_mode]) ::
  {program, outputs} | run_error
  defp run(program, inputs, outputs, current_instruction_pointer, opcode, parameter_modes)



  # Opcodes
  #
  #  -  1   Add
  #  -  2   Multiply
  #
  defp run(
    program,
    inputs,
    outputs,
    current_instruction_pointer,
    current_opcode,
    [pm1, pm2, 0]
  ) when current_opcode in [1, 2] do

    [p1, p2, result_pointer] =
      instruction_parameters(
        program,
        current_instruction_pointer,
        # Retrieve the third parameter as a pointer, i.e. as-if it was a regular 'immediate mode'
        # parameter:
        [pm1, pm2, 1]
      )

    computed_value =
      case current_opcode do
        1 -> p1 + p2
        2 -> p1 * p2
      end

    program
    |> List.replace_at(result_pointer, computed_value)
    |> run(
      inputs,
      outputs,
      current_instruction_pointer + 4
    )
  end



  # Opcode
  #
  #  -  3   Input
  #


  defp run(program, [input | inputs_tail], outputs, current_instruction_pointer, 3, _parameter_modes) do
    result_pointer = Enum.at(program, current_instruction_pointer + 1)

    program
    |> List.replace_at(result_pointer, input)
    |> run(
      inputs_tail,
      outputs,
      current_instruction_pointer + 2
    )
  end


  defp run(program, [] = inputs, outputs, current_instruction_pointer, 3 = current_opcode, parameter_modes) do
    error(
      "There are no inputs.",
      program,
      inputs,
      outputs,
      current_instruction_pointer,
      current_opcode,
      parameter_modes
    )
  end



  # Opcode
  #
  #  -  4   Output
  #
  defp run(program, inputs, outputs, current_instruction_pointer, 4, [pm, _, _]) do
    [parameter] =
      instruction_parameters(
        program,
        current_instruction_pointer,
        [pm]
      )

    run(
      program,
      inputs,
      [parameter | outputs],
      current_instruction_pointer + 2
    )
  end


  # Opcode
  #
  #  -  5   Jump-if-true
  #
  defp run(program, inputs, outputs, current_instruction_pointer, 5, [pm1, pm2, _]) do
    [parameter, jump_pointer] =
      instruction_parameters(
        program,
        current_instruction_pointer,
        [pm1, pm2]
      )

    next_instruction_pointer =
      case parameter do
        0 -> current_instruction_pointer + 3
        _ -> jump_pointer
      end

    run(program, inputs, outputs, next_instruction_pointer)
  end


  # Opcode
  #
  #  -  6   Jump-if-false
  #
  defp run(program, inputs, outputs, current_instruction_pointer, 6, [pm1, pm2, _]) do
    [parameter, jump_pointer] =
      instruction_parameters(
        program,
        current_instruction_pointer,
        [pm1, pm2]
      )

    next_instruction_pointer =
      case parameter do
        0 -> jump_pointer
        _ -> current_instruction_pointer + 3
      end

    run(program, inputs, outputs, next_instruction_pointer)
  end


  # Opcode
  #
  #  -  7   Less-than
  #
  defp run(program, inputs, outputs, current_instruction_pointer, 7, [pm1, pm2, 0]) do
    [p1, p2, result_pointer] =
      instruction_parameters(
        program,
        current_instruction_pointer,
        # Retrieve the third parameter as a pointer, i.e. as-if it was a regular 'immediate mode'
        # parameter:
        [pm1, pm2, 1]
      )

    computed_value =
      cond do
        p1 < p2 -> 1
        true    -> 0
      end

    program
    |> List.replace_at(result_pointer, computed_value)
    |> run(
      inputs,
      outputs,
      current_instruction_pointer + 4
    )
  end


  # Opcode
  #
  #  -  8   Equals
  #
  defp run(program, inputs, outputs, current_instruction_pointer, 8, [pm1, pm2, 0]) do
    [p1, p2, result_pointer] =
      instruction_parameters(
        program,
        current_instruction_pointer,
        # Retrieve the third parameter as a pointer, i.e. as-if it was a regular 'immediate mode'
        # parameter:
        [pm1, pm2, 1]
      )

    computed_value =
      cond do
        p1 == p2 -> 1
        true     -> 0
      end

    program
    |> List.replace_at(result_pointer, computed_value)
    |> run(
      inputs,
      outputs,
      current_instruction_pointer + 4
    )
  end


  # Opcode
  #
  #  - 99   Halt
  #
  defp run(program, _inputs, outputs, _current_instruction_pointer, 99, _parameter_modes) do
    {
      program,
      Enum.reverse(outputs)
    }
  end


  defp run(
    program,
    inputs,
    outputs,
    current_instruction_pointer,
    current_opcode,
    [_, _, 1] = parameter_modes
  ) do

    error(
      "Invalid parameter 3 mode; parameters that an instruction writes to cannot be in immediate mode.",
      program,
      inputs,
      outputs,
      current_instruction_pointer,
      current_opcode,
      parameter_modes
    )
  end


  defp run(program, inputs, outputs, current_instruction_pointer, current_opcode, parameter_modes) do
    error(
      "Encountered an unknown opcode; something went wrong.",
      program,
      inputs,
      outputs,
      current_instruction_pointer,
      current_opcode,
      parameter_modes
    )
  end




  @type error_message :: String.t

  @type run_error ::
  {
    :error,
    error_message,
    %{
        program:                     program,
        remaining_inputs:            inputs,
        outputs:                     outputs,
        current_instruction_pointer: pointer,
        current_opcode:              opcode,
        parameter_modes:             [parameter_mode]
    }
  }

  @spec error(error_message, program, inputs, outputs, pointer, opcode, [parameter_mode]) :: run_error
  def error(message, program, inputs, outputs, current_instruction_pointer, current_opcode, parameter_modes) do
    {
      :error,
      message,
      %{
        program:                     program,
        remaining_inputs:            inputs,
        outputs:                     outputs,
        current_instruction_pointer: current_instruction_pointer,
        current_opcode:              current_opcode,
        parameter_modes:             parameter_modes
      }
    }
  end

  @spec process_input() :: value
  def process_input() do
    AdventOfCode2019.Day2Puzzle2.process_input(12, 2)
  end

  @spec parse_program_string(String.t) :: program
  def parse_program_string(program_string) do
    program_string
    |> String.trim_trailing() # Trim, e.g. newline, character(s)
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

end
