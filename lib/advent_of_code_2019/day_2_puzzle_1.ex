defmodule AdventOfCode2019.Day2Puzzle1 do

  alias AdventOfCode2019.IntcodeComputerProgram

  @type value   :: integer
  @type program :: AdventOfCode2019.IntcodeComputerProgram.t
  @type input   :: integer
  @type inputs  :: [input]
  @type output  :: integer
  @type outputs :: [output]
  @type pointer :: non_neg_integer
  @type opcode  :: pos_integer

  @type relative_base :: AdventOfCode2019.Day9Puzzle1.relative_base

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
        parameter_modes:             [parameter_mode],
        relative_base:               relative_base
    }
  }

  @type run_return ::
  {:halted, program, outputs}
  | {:waiting_for_input, program, pointer, outputs, relative_base}
  | run_error

  @spec run(program, inputs) :: run_return
  def run(program, inputs \\ []) do
    run(program, inputs, [], 0, 0)
  end


  @spec run(program, inputs, outputs, pointer, relative_base) :: run_return
  def run(program, inputs, outputs, current_instruction_pointer, relative_base) do
    {opcode, parameter_modes} =
      AdventOfCode2019.Day5Puzzle1.parse_instruction(
        IntcodeComputerProgram.at(program, current_instruction_pointer)
      )

    run(
      program,
      inputs,
      outputs,
      current_instruction_pointer,
      opcode,
      parameter_modes,
      relative_base
    )
  end


  @type parameter_type :: :input | :output

  @type parameter_mode :: AdventOfCode2019.Day5Puzzle1.parameter_mode

  @type parameter_error_type :: :invalid_immediate_mode_for_output_parameter
  @type parameter_error      :: {:error, parameter_error_type}


  @spec instruction_parameter(program, value, parameter_type, parameter_mode, relative_base) ::
  value | parameter_error
  def instruction_parameter(
    program,
    parameter_pointer_or_value,
    parameter_type,
    parameter_mode,
    relative_base
  )

  def instruction_parameter(program, pointer, :input, 0, _relative_base) do
    IntcodeComputerProgram.at(program, pointer)
  end

  def instruction_parameter(_program, value, :input, 1, _relative_base), do: value

  def instruction_parameter(program, relative_pointer, :input, 2, relative_base) do
    IntcodeComputerProgram.at(
      program,
      relative_base + relative_pointer
    )
  end

  def instruction_parameter(_program, pointer, :output, 0, _relative_base), do: pointer

  def instruction_parameter(_program, _value, :output, 1, _relative_base) do
    {:error, :invalid_immediate_mode_for_output_parameter}
  end

  def instruction_parameter(_program, relative_pointer, :output, 2, relative_base) do
    relative_base + relative_pointer
  end


  @type parameters_error_type :: :different_number_of_types_and_modes
  @type parameters_error      :: {:error, parameters_error_type}


  @spec instruction_parameters(
    program,
    pointer,
    [parameter_type],
    [parameter_mode],
    relative_base
  ) :: [value | parameter_error] | parameters_error
  def instruction_parameters(
    program,
    instruction_pointer,
    parameter_types,
    parameter_modes,
    relative_base
  )
  do

    if length(parameter_types) != length(parameter_modes) do
      {:error, :different_number_of_types_and_modes}
    else
      Enum.zip(
        [
          IntcodeComputerProgram.slice(
            program,
            instruction_pointer + 1,
            length(parameter_modes)
          ),
          parameter_types,
          parameter_modes
        ]
      )
      |> Enum.map(
        fn {pointer_or_value, parameter_type, parameter_mode} ->
          instruction_parameter(
            program,
            pointer_or_value,
            parameter_type,
            parameter_mode,
            relative_base
          )
        end
      )
    end
  end




  @spec run(program, inputs, outputs, pointer, opcode, [parameter_mode], relative_base) ::
  run_return
  def run(
    program,
    inputs,
    outputs,
    current_instruction_pointer,
    opcode,
    parameter_modes,
    relative_base
  )



  # Opcodes
  #
  #  -  1   Add
  #  -  2   Multiply
  #
  def run(
    program,
    inputs,
    outputs,
    current_instruction_pointer,
    current_opcode,
    parameter_modes,
    relative_base
  ) when current_opcode in [1, 2] do
    
    AdventOfCode2019.Day9Puzzle1.run_with_parameters(
      program,
      inputs,
      outputs,
      current_instruction_pointer,
      current_opcode,
      [:input, :input, :output],
      parameter_modes,
      relative_base,
      fn 
        program,
        inputs,
        outputs,
        current_instruction_pointer,
        current_opcode,
        relative_base,
        [p1, p2, result_pointer]
        ->

          computed_value =
            case current_opcode do
              1 -> p1 + p2
              2 -> p1 * p2
            end

          program
          |> IntcodeComputerProgram.update_at(result_pointer, computed_value)
          |> run(
            inputs,
            outputs,
            current_instruction_pointer + 4,
            relative_base
          )
      end
    )
  end



  # Opcode
  #
  #  -  3   Input
  #


  def run(
    program,
    [] = _inputs,
    outputs,
    current_instruction_pointer,
    3 = _current_opcode,
    _parameter_modes,
    relative_base
  ) do

    {
      :waiting_for_input,
      program,
      current_instruction_pointer,
      Enum.reverse(outputs),
      relative_base
    }
  end


  def run(
    program,
    inputs,
    outputs,
    current_instruction_pointer,
    3 = current_opcode,
    [pm, _, _],
    relative_base
  )
  do

    AdventOfCode2019.Day9Puzzle1.run_with_parameters(
      program,
      inputs,
      outputs,
      current_instruction_pointer,
      current_opcode,
      [:output],
      [pm],
      relative_base,
      fn 
        program,
        [input | inputs_tail],
        outputs,
        current_instruction_pointer,
        _current_opcode,
        relative_base,
        [result_pointer]
        ->

          program
          |> IntcodeComputerProgram.update_at(result_pointer, input)
          |> run(
            inputs_tail,
            outputs,
            current_instruction_pointer + 2,
            relative_base
          )
      end
    )
  end



  # Opcode
  #
  #  -  4   Output
  #
  def run(
    program,
    inputs,
    outputs,
    current_instruction_pointer,
    4 = current_opcode,
    [pm, _, _],
    relative_base
  ) do

    AdventOfCode2019.Day9Puzzle1.run_with_parameters(
      program,
      inputs,
      outputs,
      current_instruction_pointer,
      current_opcode,
      [:input],
      [pm],
      relative_base,
      fn 
        program,
        inputs,
        outputs,
        current_instruction_pointer,
        _current_opcode,
        relative_base,
        [parameter]
        ->

          run(
            program,
            inputs,
            [parameter | outputs],
            current_instruction_pointer + 2,
            relative_base
          )
      end
    )

  end


  # Opcode
  #
  #  -  5   Jump-if-true
  #
  def run(
    program,
    inputs,
    outputs,
    current_instruction_pointer,
    5 = current_opcode,
    [pm1, pm2, _],
    relative_base
  ) do

    AdventOfCode2019.Day9Puzzle1.run_with_parameters(
      program,
      inputs,
      outputs,
      current_instruction_pointer,
      current_opcode,
      [:input, :input],
      [pm1, pm2],
      relative_base,
      fn 
        program,
        inputs,
        outputs,
        current_instruction_pointer,
        _current_opcode,
        relative_base,
        [parameter, jump_pointer]
        ->

          next_instruction_pointer =
            case parameter do
              0 -> current_instruction_pointer + 3
              _ -> jump_pointer
            end

          run(program, inputs, outputs, next_instruction_pointer, relative_base)
      end
    )
  end


  # Opcode
  #
  #  -  6   Jump-if-false
  #
  def run(
    program,
    inputs,
    outputs,
    current_instruction_pointer,
    6 = current_opcode,
    [pm1, pm2, _],
    relative_base
  ) do

    AdventOfCode2019.Day9Puzzle1.run_with_parameters(
      program,
      inputs,
      outputs,
      current_instruction_pointer,
      current_opcode,
      [:input, :input],
      [pm1, pm2],
      relative_base,
      fn 
        program,
        inputs,
        outputs,
        current_instruction_pointer,
        _current_opcode,
        relative_base,
        [parameter, jump_pointer]
        ->

          next_instruction_pointer =
            case parameter do
              0 -> jump_pointer
              _ -> current_instruction_pointer + 3
            end

          run(program, inputs, outputs, next_instruction_pointer, relative_base)
      end
    )
  end


  # Opcode
  #
  #  -  7   Less-than
  #
  def run(
    program,
    inputs,
    outputs,
    current_instruction_pointer,
    7 = current_opcode,
    parameter_modes,
    relative_base
  ) do

    AdventOfCode2019.Day9Puzzle1.run_with_parameters(
      program,
      inputs,
      outputs,
      current_instruction_pointer,
      current_opcode,
      [:input, :input, :output],
      parameter_modes,
      relative_base,
      fn 
        program,
        inputs,
        outputs,
        current_instruction_pointer,
        _current_opcode,
        relative_base,
        [p1, p2, result_pointer]
        ->

          computed_value =
            cond do
              p1 < p2 -> 1
              true    -> 0
            end

          program
          |> IntcodeComputerProgram.update_at(result_pointer, computed_value)
          |> run(
            inputs,
            outputs,
            current_instruction_pointer + 4,
            relative_base
          )
      end
    )
  end


  # Opcode
  #
  #  -  8   Equals
  #
  def run(
    program,
    inputs,
    outputs,
    current_instruction_pointer,
    8 = current_opcode,
    parameter_modes,
    relative_base
  )
  do

    AdventOfCode2019.Day9Puzzle1.run_with_parameters(
      program,
      inputs,
      outputs,
      current_instruction_pointer,
      current_opcode,
      [:input, :input, :output],
      parameter_modes,
      relative_base,
      fn 
        program,
        inputs,
        outputs,
        current_instruction_pointer,
        _current_opcode,
        relative_base,
        [p1, p2, result_pointer]
        ->

          computed_value =
            cond do
              p1 == p2 -> 1
              true     -> 0
            end

          program
          |> IntcodeComputerProgram.update_at(result_pointer, computed_value)
          |> run(
            inputs,
            outputs,
            current_instruction_pointer + 4,
            relative_base
          )
      end
    )
  end


  # Opcode
  #
  #  -  9   Relative base offset
  #
  def run(
    program,
    inputs,
    outputs,
    current_instruction_pointer,
    9 = current_opcode,
    [pm, _, _],
    relative_base
  ) do

    AdventOfCode2019.Day9Puzzle1.run_with_parameters(
      program,
      inputs,
      outputs,
      current_instruction_pointer,
      current_opcode,
      [:input],
      [pm],
      relative_base,
      fn 
        program,
        inputs,
        outputs,
        current_instruction_pointer,
        _current_opcode,
        relative_base,
        [offset]
        ->

          #
          run(
            program,
            inputs,
            outputs,
            current_instruction_pointer + 2,
            relative_base + offset
          )
      end
    )
  end


  # Opcode
  #
  #  - 99   Halt
  #
  def run(
    program,
    _inputs,
    outputs,
    _current_instruction_pointer,
    99,
    _parameter_modes,
    _relative_base
  ) do

    {
      :halted,
      program,
      Enum.reverse(outputs)
    }
  end


  def run(
    program,
    inputs,
    outputs,
    current_instruction_pointer,
    current_opcode,
    parameter_modes,
    relative_base
  ) do

    error(
      ["Encountered an unknown opcode; something went wrong."],
      program,
      inputs,
      outputs,
      current_instruction_pointer,
      current_opcode,
      parameter_modes,
      relative_base
    )
  end




  @type error_message :: String.t

  @spec error(
    [error_message],
    program,
    inputs,
    outputs,
    pointer,
    opcode,
    [parameter_mode],
    relative_base
  ) :: run_error
  def error(
    messages,
    program,
    inputs,
    outputs,
    current_instruction_pointer,
    current_opcode,
    parameter_modes,
    relative_base
  ) do

    {
      :error,
      messages,
      %{
        program:                     program,
        remaining_inputs:            inputs,
        outputs:                     outputs,
        current_instruction_pointer: current_instruction_pointer,
        current_opcode:              current_opcode,
        parameter_modes:             parameter_modes,
        relative_base:               relative_base
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
    |> IntcodeComputerProgram.new()
  end

end
