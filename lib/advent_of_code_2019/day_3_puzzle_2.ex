defmodule AdventOfCode2019.Day3Puzzle2 do
  import AdventOfCode2019.Day3Puzzle1, except: [process_input: 0, output_answer: 0]


  # Because `import` doesn't 'import' types:
  @type wire_number :: AdventOfCode2019.Day3Puzzle1.wire_number
  @type step        :: AdventOfCode2019.Day3Puzzle1.step
  @type wire_item   :: AdventOfCode2019.Day3Puzzle1.wire_item


  @spec wire_number_and_step(wire_item) :: {wire_number, step}
  def wire_number_and_step(item) do
    case item do
      {:wire_length, wire_number, step, _direction} -> {wire_number, step}
      {:wire_bend, wire_number, step}               -> {wire_number, step}
    end
  end

  # Because `import` doesn't 'import' types:
  @type position :: AdventOfCode2019.Day3Puzzle1.position
  @type panel    :: AdventOfCode2019.Day3Puzzle1.panel

  @type signal_delay :: pos_integer


  @spec minimal_signal_delay_intersection(panel) :: {position, signal_delay, [{wire_number, step}]} | :no_intersections
  def minimal_signal_delay_intersection(panel) do
    panel.intersections
    |> Enum.map(
      fn {position, wire_items} ->
        wire_numbers_and_steps = Enum.map(wire_items, &wire_number_and_step/1)

        {
          position,
          Enum.map(wire_numbers_and_steps, fn {_, step} -> step end) |> Enum.sum(),
          wire_numbers_and_steps
        }
      end
    )
    |> Enum.min_by(
      fn {_position, signal_delay, _wire_numbers_and_steps} -> signal_delay end,
      fn -> :no_intersections end
    )
  end


  def process_input() do
    input_panel()
    |> minimal_signal_delay_intersection()
  end

  def output_answer() do
    {_position, signal_delay, _wire_numbers_and_steps} = process_input()
    signal_delay
  end


end
