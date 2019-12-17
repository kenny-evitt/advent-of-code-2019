defmodule AdventOfCode2019.Day7Puzzle1 do

  @type value   :: AdventOfCode2019.Day2Puzzle1.value
  @type program :: AdventOfCode2019.Day2Puzzle1.program
  @type input   :: AdventOfCode2019.Day2Puzzle1.input
  @type inputs  :: AdventOfCode2019.Day2Puzzle1.inputs
  @type output  :: AdventOfCode2019.Day2Puzzle1.output
  @type outputs :: AdventOfCode2019.Day2Puzzle1.outputs

  @type phase_setting  :: 0..4
  @type phase_settings :: [phase_setting]

  @spec run_amplifiers(program, phase_settings) :: output
  def run_amplifiers(program, phase_settings) do
    Enum.reduce(
      phase_settings,
      nil,
      fn phase_setting, previous_output ->
        run_amplifier(
          program,
          phase_setting,
          case previous_output do
            nil -> 0
            x -> x
          end
        )
      end
    )
  end


  @spec run_amplifier(program, phase_setting, input) :: output
  def run_amplifier(program, phase_setting, input) do
    {:halted, _final_program, [output]} =
      AdventOfCode2019.Day2Puzzle1.run(program, [phase_setting, input])

    output
  end


  @spec phase_setting_list() :: phase_settings
  def phase_setting_list(), do: [0, 1, 2, 3, 4]

  @spec all_possible_sets_of_phase_settings() :: [phase_settings]
  def all_possible_sets_of_phase_settings() do
    all_possible_sets_of_phase_settings(
      phase_setting_list()
    )
  end

  @type general_phase_setting  :: input
  @type general_phase_settings :: [general_phase_setting]


  @spec all_possible_sets_of_phase_settings(general_phase_settings) :: [general_phase_settings]
  def all_possible_sets_of_phase_settings(phase_setting_list) do
    for ia <- 0..4,
        ib <- 0..3,
        ic <- 0..2,
        id <- 0..1 do

      {[a, b, c, d], [e]} =
        Enum.reduce(
          [ia, ib, ic, id],
          {[], phase_setting_list},
          fn i, {current_settings, remaining_settings} ->
            {setting, remaining_remaining_settings} = List.pop_at(remaining_settings, i)
            {current_settings ++ [setting], remaining_remaining_settings}
          end
        )

      [a, b, c, d, e]
    end
  end


  @spec find_phase_settings_with_max_output(program) :: {phase_settings, output}
  def find_phase_settings_with_max_output(program) do
    find_phase_settings_with_max_output(
      program,
      all_possible_sets_of_phase_settings(),
      &run_amplifiers/2
    )
  end

  @type run_amplifiers_fn :: (program, general_phase_settings -> output)


  @spec find_phase_settings_with_max_output(program, [general_phase_settings], run_amplifiers_fn) ::
  {general_phase_settings, output}
  def find_phase_settings_with_max_output(
    program,
    all_possible_sets_of_phase_settings,
    run_amplifiers_fn
  ) do

    [first_set_of_phase_settings | rest_of_set_of_phase_settings] =
      all_possible_sets_of_phase_settings

    first_output = run_amplifiers_fn.(program, first_set_of_phase_settings)

    Enum.reduce(
      rest_of_set_of_phase_settings,
      {first_set_of_phase_settings, first_output},
      fn phase_settings, {phase_settings_with_max_output, max_output} ->
        output = run_amplifiers_fn.(program, phase_settings)

        if output > max_output do
          {phase_settings, output}
        else
          {phase_settings_with_max_output, max_output}
        end
      end
    )
  end


  @spec process_input() :: output
  def process_input() do
    {:ok, input} = File.read("input/day-7-puzzle-1")
    program = AdventOfCode2019.Day2Puzzle1.parse_program_string(input)
    {_, output} = find_phase_settings_with_max_output(program)
    output
  end

end
