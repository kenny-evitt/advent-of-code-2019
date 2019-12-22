defmodule AdventOfCode2019.Day7Puzzle2 do

  @type program :: AdventOfCode2019.Day2Puzzle1.program
  @type output  :: AdventOfCode2019.Day2Puzzle1.output
  @type pointer :: AdventOfCode2019.Day2Puzzle1.pointer
  @type inputs  :: AdventOfCode2019.Day2Puzzle1.inputs
  @type outputs :: AdventOfCode2019.Day2Puzzle1.outputs

  @type phase_setting      :: 5..9
  @type phase_settings     :: [phase_setting]
  @type inputs_list        :: [inputs]
  @type program_stop_state :: :halted | :waiting_for_input

  @type amplifier ::
  {
    program_stop_state | nil,
    program,
    pointer | nil
  }

  @type amplifiers :: [amplifier]


  @spec run_amplifiers(program, phase_settings) :: {amplifiers, outputs}
  def run_amplifiers(program, phase_settings) do

    inputs_list = 
      phase_settings
      # "To start the process, a 0 signal is sent to amplifier A's input exactly once.":
      |> List.update_at(0, fn phase_setting -> [phase_setting, 0] end)
      |> Enum.map(&List.wrap/1)

    amplifiers = Enum.map(1..5, fn _ -> {nil, program, 0} end)

    run_amplifiers_(amplifiers, inputs_list)
  end


  @spec run_amplifiers_(amplifiers, inputs_list) :: {amplifiers, outputs}
  def run_amplifiers_(amplifiers, inputs_list) do
    {new_amplifiers, new_outputs} =
      run_amplifiers_once(amplifiers, inputs_list)

    any_amplifier_programs_halted? =
      Enum.any?(
        new_amplifiers,
        fn {program_stop_state, _, _} -> program_stop_state == :halted end
      )

    if any_amplifier_programs_halted? do
      {new_amplifiers, new_outputs}
    else
      run_amplifiers_(new_amplifiers, [new_outputs])
    end
  end


  @spec find_phase_settings_with_max_output(program) :: {phase_settings, output}
  def find_phase_settings_with_max_output(program) do

    run_amplifiers_fn =
      fn program, phase_settings ->
        {_amplifiers, [output]} =
          run_amplifiers(program, phase_settings)

        output
      end

    all_possible_sets_of_phase_settings =
      AdventOfCode2019.Day7Puzzle1.all_possible_sets_of_phase_settings(
        phase_setting_list()
      )

    AdventOfCode2019.Day7Puzzle1.find_phase_settings_with_max_output(
      program,
      all_possible_sets_of_phase_settings,
      run_amplifiers_fn
    )
  end


  @spec phase_setting_list() :: phase_settings
  def phase_setting_list(), do: [5, 6, 7, 8, 9]

  @type amplifier_run_return :: {amplifier, outputs}



  @spec run_amplifier(amplifier, inputs) :: amplifier_run_return
  def run_amplifier(amplifier, inputs)

  def run_amplifier({:halted, program, _pointer}, _inputs), do: {:halted, program, []}


  def run_amplifier({_, program, pointer}, inputs) do

    run_return =
      AdventOfCode2019.Day2Puzzle1.run(
        program,
        inputs,
        [],
        pointer,
        0
      )

    case run_return do
      {:halted, program, outputs}                                     ->
        { {:halted,            program, nil    }, outputs }

      {:waiting_for_input, program, pointer, outputs, _relative_base} ->
        { {:waiting_for_input, program, pointer}, outputs }
    end
  end



  @spec run_amplifiers_once(amplifiers, inputs_list) :: {amplifiers, outputs}
  def run_amplifiers_once(amplifiers, inputs_list) do

    Enum.zip(
      amplifiers,
      pad_inputs_list(inputs_list, length(amplifiers))
    )
    |> Enum.reduce(
      {[], []},
      fn {amplifier, inputs}, {new_amplifiers, previous_outputs} ->

        {new_amplifier, new_outputs} =
          run_amplifier(
            amplifier,
            inputs ++ previous_outputs
          )

        {
          new_amplifiers ++ [new_amplifier],
          new_outputs
        }
      end
    )
  end


  @spec pad_inputs_list(inputs_list, non_neg_integer) :: inputs_list
  def pad_inputs_list(inputs_list, length)

  def pad_inputs_list(inputs_list, length) when length(inputs_list) > length do
    raise("Inputs list is greater than the specified length.")
  end

  def pad_inputs_list(inputs_list, length) when length(inputs_list) == length, do: inputs_list

  def pad_inputs_list(inputs_list, length) when length(inputs_list) < length do
    inputs_list
    ++
      Enum.map(
        1..(length - length(inputs_list)),
        fn _ -> [] end
      )
  end


  @spec process_input() :: output
  def process_input() do
    {:ok, input} = File.read("input/day-7")
    program = AdventOfCode2019.Day2Puzzle1.parse_program_string(input)
    {_, output} = find_phase_settings_with_max_output(program)
    output
  end


end
