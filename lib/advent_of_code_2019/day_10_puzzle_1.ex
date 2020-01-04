defmodule AdventOfCode2019.Day10Puzzle1 do

  @type raw_map            :: String.t
  @type position_component :: non_neg_integer
  @type position           :: {position_component, position_component}
  @type asteroid_map       :: %{required(position) => true}

  @spec parse_raw_map(raw_map) :: asteroid_map
  def parse_raw_map(raw_map) do
    raw_map
    |> String.trim_trailing() # Trim, e.g. newline, character(s)
    |> String.split()
    |> Enum.with_index()
    |> Enum.flat_map(&parse_raw_map_row/1)
    |> Map.new()
  end

  @spec parse_raw_map_row({String.t, position_component}) :: asteroid_map
  def parse_raw_map_row({raw_map_row, y}) do
    raw_map_row
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.filter(fn {map_character, _x} -> map_character == "#" end)
    |> Enum.map(fn {_map_character, x} -> {{x, y}, true} end)
    |> Map.new()
  end


  @spec line_of_sight?(asteroid_map, position, position) :: boolean
  def line_of_sight?(asteroid_map, {x1, y1}, {x2, y2}) do
    dx    = x2 - x1
    dy    = y2 - y1
    d_gcd = Integer.gcd(dx, dy)

    if d_gcd == 1 do
      true
    else
      dx_step = div(dx, d_gcd)
      dy_step = div(dy, d_gcd)

      (for step <- 1..(d_gcd - 1), do: {x1 + (step * dx_step), y1 + (step * dy_step)})
      |> Enum.all?(&(asteroid_map[&1] != true))
    end
  end


  @spec detectable_asteroids(asteroid_map, position) :: [position]
  def detectable_asteroids(asteroid_map, position) do
    asteroid_map
    |> Map.keys()
    |> Enum.reject(&(&1 == position))
    |> Enum.filter(&(line_of_sight?(asteroid_map, position, &1)))
  end

  @spec best_monitoring_station_location(asteroid_map) :: {position, non_neg_integer}
  def best_monitoring_station_location(asteroid_map) do
    asteroid_map
    |> Map.keys()
    |> Enum.map(
      fn p ->
        {
          p, 
          length(
            detectable_asteroids(asteroid_map, p)
          )
        }
      end
    )
    |> Enum.max_by(fn {_p, detectable_asteroids_count} -> detectable_asteroids_count end)
  end

  @spec process_input() :: non_neg_integer
  def process_input() do
    {:ok, raw_map} = File.read("input/day-10")
    asteroid_map = parse_raw_map(raw_map)
    {_position, detectable_asteroids_count} = best_monitoring_station_location(asteroid_map)
    detectable_asteroids_count
  end

end
