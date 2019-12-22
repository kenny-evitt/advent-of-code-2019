defmodule AdventOfCode2019.Day6Puzzle2 do

  @type orbit_map   :: AdventOfCode2019.Day6Puzzle1.orbit_map
  @type object_name :: AdventOfCode2019.Day6Puzzle1.object_name

  @spec ancestor_orbits(orbit_map, object_name) :: [object_name]
  def ancestor_orbits(orbit_map, object_name) do
    case orbit_map.parents[object_name] do
      nil -> []
      parent_object_name -> [parent_object_name | ancestor_orbits(orbit_map, parent_object_name)]
    end
  end

  @type orbit_count :: AdventOfCode2019.Day6Puzzle1.orbit_count


  @spec minimum_number_of_orbit_transfers(orbit_map, object_name, object_name) :: orbit_count
  def minimum_number_of_orbit_transfers(orbit_map, transfer_object_name, target_object_name) do
    transfer_object_ancestors = ancestor_orbits(orbit_map, transfer_object_name)
    target_object_ancestors   = ancestor_orbits(orbit_map, target_object_name)

    length(
      minimum_orbit_transfers(transfer_object_ancestors, target_object_ancestors)
    )
  end


  @type orbit_transfer  :: {object_name, object_name}
  @type orbit_transfers :: [orbit_transfer]


  @spec to_transfers([object_name]) :: orbit_transfers
  def to_transfers(orbits) do
    length = length(orbits)

    Enum.zip(
      Enum.slice(orbits, 0..(length - 2)),
      Enum.slice(orbits, 1..(length - 1))
    )
  end


  @spec minimum_orbit_transfers(orbit_transfers, orbit_transfers) ::
  orbit_transfers | :no_common_orbit_ancestor
  def minimum_orbit_transfers(transfer_object_ancestors, target_object_ancestors) do
    minimum_orbit_transfers(
      [],
      transfer_object_ancestors,
      Enum.reverse(target_object_ancestors)
    )
  end



  @spec minimum_orbit_transfers(orbit_transfers, [object_name], [object_name]) ::
  orbit_transfers | :no_common_orbit_ancestor
  def minimum_orbit_transfers(
    current_transfers,
    [next_transfer_object_ancestor | remaining_transfer_object_ancestors] = _transfer_object_ancestors,
    reverse_target_object_ancestors
  ) do

    case Enum.find_index(reverse_target_object_ancestors, &(&1 == next_transfer_object_ancestor)) do
      nil ->
        case remaining_transfer_object_ancestors do
          [] -> :no_common_orbit_ancestor

          [next_next_transfer_object_ancestor | _] ->
            minimum_orbit_transfers(
              [
                {next_transfer_object_ancestor, next_next_transfer_object_ancestor}
                | current_transfers
              ],
              remaining_transfer_object_ancestors,
              reverse_target_object_ancestors
            )
        end

      index ->
        Enum.reverse(current_transfers)
        ++
          to_transfers(
            Enum.slice(
              reverse_target_object_ancestors,
              index..(length(reverse_target_object_ancestors) - 1)
            )
          )
    end
  end


  def minimum_orbit_transfers(_current_transfers, [], _target_object_ancestors) do
    :no_common_orbit_ancestor
  end



  @spec process_input() :: orbit_count
  def process_input() do
    {:ok, input} = File.read("input/day-6")

    input
    |> AdventOfCode2019.Day6Puzzle1.parse_orbit_map()
    |> minimum_number_of_orbit_transfers("YOU", "SAN")
  end

end
