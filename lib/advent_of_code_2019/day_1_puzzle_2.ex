defmodule AdventOfCode2019.Day1Puzzle2 do
  alias AdventOfCode2019.Day1Puzzle1
  
  def fuel_required(mass) do
    case Day1Puzzle1.module_fuel_required(mass) do
      fuel0 when fuel0 <= 0 -> 0
      fuel0                 -> fuel0 + fuel_required(fuel0)
    end
  end


  def process_input() do
    {:ok, input} = File.read("input/day-1-puzzle-1")

    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(
      0,
      fn module_mass, running_total ->
        running_total + fuel_required(module_mass)
      end
    )
  end


end
