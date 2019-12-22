defmodule AdventOfCode2019.Day9Puzzle1 do

  @type value :: AdventOfCode2019.Day2Puzzle1.value

  @type relative_base :: value


  @spec process_input() :: value
  def process_input() do
    {:ok, input} = File.read("input/day-9")

    {:halted, _, [output]} =
      input
      |> AdventOfCode2019.Day2Puzzle1.parse_program_string()
      |> AdventOfCode2019.Day2Puzzle1.run([1])

    output
  end


  @type program        :: AdventOfCode2019.Day2Puzzle1.program
  @type inputs         :: AdventOfCode2019.Day2Puzzle1.inputs
  @type outputs        :: AdventOfCode2019.Day2Puzzle1.outputs
  @type pointer        :: AdventOfCode2019.Day2Puzzle1.pointer
  @type opcode         :: AdventOfCode2019.Day2Puzzle1.opcode
  @type run_return     :: AdventOfCode2019.Day2Puzzle1.run_return
  @type parameter_type :: AdventOfCode2019.Day2Puzzle1.parameter_type
  @type parameter_mode :: AdventOfCode2019.Day2Puzzle1.parameter_mode

  @type run_fn ::
  (
    program,
    inputs,
    outputs,
    pointer,
    opcode,
    relative_base,
    [value]
    -> run_return
  )


  @spec run_with_parameters(
    program,
    inputs,
    outputs,
    pointer,
    opcode,
    [parameter_type],
    [parameter_mode],
    relative_base,
    run_fn
  ) :: run_return
  def run_with_parameters(
    program,
    inputs,
    outputs,
    current_instruction_pointer,
    current_opcode,
    parameter_types,
    parameter_modes,
    relative_base,
    run_fn
  ) do

    parameters_return =
      AdventOfCode2019.Day2Puzzle1.instruction_parameters(
        program,
        current_instruction_pointer,
        parameter_types,
        parameter_modes,
        relative_base
      )

    case parameters_return do

      {:error, :different_number_of_types_and_modes} ->

        AdventOfCode2019.Day2Puzzle1.error(
          ["The number of parameter types and parameter modes don't match."],
          program,
          inputs,
          outputs,
          current_instruction_pointer,
          current_opcode,
          parameter_modes,
          relative_base
        )

      parameter_returns ->

        values_or_errors =
          parameter_returns
          |> Enum.with_index(1)
          |> Enum.reduce(
            {:ok, []},
            fn {value_or_error, index}, values_or_errors ->
              case values_or_errors do
                {:error, errors} ->
                  case value_or_error do
                    {:error, error_type} ->
                      error = parameter_error_message(error_type, index)
                      {:error, [error | errors]}

                    _value -> {:error, errors}
                  end

                {:ok, values} ->
                  case value_or_error do
                    {:error, error_type} ->
                      error = parameter_error_message(error_type, index)
                      {:error, [error]}

                    value -> {:ok, [value | values]}
                  end
              end
            end
          )

        case values_or_errors do
          {:error, errors} ->
            AdventOfCode2019.Day2Puzzle1.error(
              Enum.reverse(errors),
              program,
              inputs,
              outputs,
              current_instruction_pointer,
              current_opcode,
              parameter_modes,
              relative_base
            )

          {:ok, values} ->
            run_fn.(
              program,
              inputs,
              outputs,
              current_instruction_pointer,
              current_opcode,
              relative_base,
              Enum.reverse(values)
            )
        end
    end
  end


  @type parameter_error_type :: AdventOfCode2019.Day2Puzzle1.parameter_error_type
  @type error_message        :: AdventOfCode2019.Day2Puzzle1.error_message

  @spec parameter_error_message(parameter_error_type, pos_integer) :: error_message
  def parameter_error_message(parameter_error_type, parameter_index) do
    case parameter_error_type do
      :invalid_immediate_mode_for_output_parameter ->
        "Invalid parameter #{parameter_index} mode; parameters that an instruction"
        <> " writes to cannot be in immediate mode."
    end
  end

end
