defmodule AdventOfCode2019.Day6Puzzle1 do

  @type object_name :: String.t

  @spec parse_orbit(String.t) :: {object_name, object_name}
  def parse_orbit(orbit_string) do
    regex = ~r/^(?<a>\w+)\)(?<b>\w+)$/
    captures = Regex.named_captures(regex, orbit_string)
    {captures["a"], captures["b"]}
  end

  @type orbit_map :: %{required(object_name) => [object_name]}

  @spec parse_orbit_map(String.t) :: orbit_map
  def parse_orbit_map(orbit_map_string) do
    orbit_map_string
    |> String.trim_trailing() # Trim, e.g. newline, character(s)
    |> String.split()
    |> Enum.map(&parse_orbit/1)
    |> Enum.reduce(
      %{},
      fn {object_a, object_b}, map ->
        Map.update(map, object_a, [object_b], fn list -> [object_b | list] end)
      end
    )
  end

  @type orbit_count :: non_neg_integer

  @type orbit_counts ::
  {
    direct_orbits_count   :: orbit_count,
    indirect_orbits_count :: non_neg_integer
  }

  @spec count_orbits(orbit_map) :: orbit_counts
  def count_orbits(orbit_map) do
    count_orbits(orbit_map, "COM", nil)
  end

  @spec add_orbit_counts([orbit_counts]) :: orbit_counts
  def add_orbit_counts(orbit_counts_enum) do
    Enum.reduce(
      orbit_counts_enum,
      {0, 0},
      fn {direct_orbits, indirect_orbits}, {total_direct_orbits, total_indirect_orbits} ->
        {
          total_direct_orbits + direct_orbits,
          total_indirect_orbits + indirect_orbits
        }
      end
    )
  end


  @spec count_orbits(orbit_map, object_name, orbit_count) :: orbit_counts
  def count_orbits(
    orbit_map,
    current_object_name,
    parent_indirect_orbits
  ) do

    direct_orbits =
      case current_object_name do
        "COM" -> 0
        _     -> 1
      end

    indirect_orbits =
      case parent_indirect_orbits do
        nil -> 0
        n   -> n + 1
      end

    case orbit_map[current_object_name] do
      nil  -> {direct_orbits, indirect_orbits}

      list ->

        {children_direct_orbits, children_indirect_orbits} =
          list
          |> Enum.map(
            fn child_object_name ->
              count_orbits(
                orbit_map,
                child_object_name,
                case current_object_name do
                  "COM" -> nil
                  _     -> indirect_orbits
                end
              )
            end
          )
          |> add_orbit_counts()

        {
          direct_orbits + children_direct_orbits,
          indirect_orbits + children_indirect_orbits
        }
    end
  end


  @spec process_input() :: orbit_count
  def process_input() do
    {:ok, input} = File.read("input/day-6-puzzle-1")

    {direct_orbits, indirect_orbits} =
      input
      |> parse_orbit_map()
      |> count_orbits()

    direct_orbits + indirect_orbits
  end


end
