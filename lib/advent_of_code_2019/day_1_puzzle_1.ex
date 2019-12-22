defmodule AdventOfCode2019.Day1Puzzle1 do
  def module_fuel_required(module_mass) do
    div(module_mass, 3) - 2
  end


  def process_input() do
    {:ok, input} = File.read("input/day-1")

    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(
      0,
      fn module_mass, running_total ->
        running_total + module_fuel_required(module_mass)
      end
    )
  end


end
