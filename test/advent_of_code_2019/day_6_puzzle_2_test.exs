defmodule AdventOfCode2019.Day6Puzzle2Test do
  use ExUnit.Case
  import AdventOfCode2019.Day6Puzzle2


  setup_all do
    orbit_map_string =
      """
      COM)B
      B)C
      C)D
      D)E
      E)F
      B)G
      G)H
      D)I
      E)J
      J)K
      K)L
      K)YOU
      I)SAN
      """

    orbit_map = AdventOfCode2019.Day6Puzzle1.parse_orbit_map(orbit_map_string)

    {:ok, orbit_map: orbit_map}
  end


  test "ancestor orbits example 0", context do
    assert ancestor_orbits(context[:orbit_map], "COM") == []
  end

  test "ancestor orbits example 1", context do
    assert ancestor_orbits(context[:orbit_map], "YOU") == ["K", "J", "E", "D", "C", "B", "COM"]
  end

  test "ancestor orbits example 2", context do
    assert ancestor_orbits(context[:orbit_map], "SAN") == ["I", "D", "C", "B", "COM"]
  end



  test "orbits to transfers example 1" do
    orbits = []
    assert to_transfers(orbits) == []
  end


  test "orbits to transfers example 2" do
    orbits = ["K", "J", "E", "D", "C", "B", "COM"]

    expected_transfers =
      [
        {"K", "J"  },
        {"J", "E"  },
        {"E", "D"  },
        {"D", "C"  },
        {"C", "B"  },
        {"B", "COM"}
      ]

    assert to_transfers(orbits) == expected_transfers
  end


  test "orbits to transfers example 3" do
    orbits = ["I", "D", "C", "B", "COM"]

    expected_transfers =
      [
        {"I", "D"  },
        {"D", "C"  },
        {"C", "B"  },
        {"B", "COM"}
      ]

    assert to_transfers(orbits) == expected_transfers
  end



  test "minimum orbit transfers example -1" do
    orbit_map_string =
      """
      A)YOU
      A)SAN
      """

    orbit_map = AdventOfCode2019.Day6Puzzle1.parse_orbit_map(orbit_map_string)

    transfer_object_ancestors = ancestor_orbits(orbit_map, "YOU")
    target_object_ancestors   = ancestor_orbits(orbit_map, "SAN")

    actual_minimum_orbit_transfers =
      minimum_orbit_transfers(transfer_object_ancestors, target_object_ancestors)

    assert actual_minimum_orbit_transfers == []
  end


  test "minimum orbit transfers example 0" do
    orbit_map_string =
      """
      A)B
      B)YOU
      A)SAN
      """

    orbit_map = AdventOfCode2019.Day6Puzzle1.parse_orbit_map(orbit_map_string)

    transfer_object_ancestors = ancestor_orbits(orbit_map, "YOU")
    target_object_ancestors   = ancestor_orbits(orbit_map, "SAN")

    actual_minimum_orbit_transfers =
      minimum_orbit_transfers(transfer_object_ancestors, target_object_ancestors)

    assert actual_minimum_orbit_transfers == [{"B", "A"}]
  end


  test "minimum orbit transfers example 1" do
    orbit_map_string =
      """
      A)YOU
      A)B
      B)SAN
      """

    orbit_map = AdventOfCode2019.Day6Puzzle1.parse_orbit_map(orbit_map_string)

    transfer_object_ancestors = ancestor_orbits(orbit_map, "YOU")
    target_object_ancestors   = ancestor_orbits(orbit_map, "SAN")

    actual_minimum_orbit_transfers =
      minimum_orbit_transfers(transfer_object_ancestors, target_object_ancestors)

    assert actual_minimum_orbit_transfers == [{"A", "B"}]
  end


  test "minimum orbit transfers example 2" do
    orbit_map_string =
      """
      A)YOU
      B)SAN
      """

    orbit_map = AdventOfCode2019.Day6Puzzle1.parse_orbit_map(orbit_map_string)

    transfer_object_ancestors = ancestor_orbits(orbit_map, "YOU")
    target_object_ancestors   = ancestor_orbits(orbit_map, "SAN")

    actual_minimum_orbit_transfers =
      minimum_orbit_transfers(transfer_object_ancestors, target_object_ancestors)

    assert actual_minimum_orbit_transfers == :no_common_orbit_ancestor
  end


  test "minimum orbit transfers example 3" do
    orbit_map_string =
      """
      YOU)SOMETHING
      A)B
      B)SAN
      """

    orbit_map = AdventOfCode2019.Day6Puzzle1.parse_orbit_map(orbit_map_string)

    transfer_object_ancestors = ancestor_orbits(orbit_map, "YOU")
    target_object_ancestors   = ancestor_orbits(orbit_map, "SAN")

    actual_minimum_orbit_transfers =
      minimum_orbit_transfers(transfer_object_ancestors, target_object_ancestors)

    assert actual_minimum_orbit_transfers == :no_common_orbit_ancestor
  end


  test "minimum orbit transfers example 4" do
    orbit_map_string =
      """
      A)YOU
      B)SAN
      """

    orbit_map = AdventOfCode2019.Day6Puzzle1.parse_orbit_map(orbit_map_string)

    transfer_object_ancestors = ancestor_orbits(orbit_map, "A") # Note the transfer object!
    target_object_ancestors   = ancestor_orbits(orbit_map, "SAN")

    actual_minimum_orbit_transfers =
      minimum_orbit_transfers(transfer_object_ancestors, target_object_ancestors)

    assert actual_minimum_orbit_transfers == :no_common_orbit_ancestor
  end


  test "minimum orbit transfers example 5", context do
    orbit_map = context[:orbit_map]

    transfer_object_ancestors = ancestor_orbits(orbit_map, "YOU")
    target_object_ancestors   = ancestor_orbits(orbit_map, "SAN")

    expected_minimum_orbit_transfers =
      [
        {"K", "J"},
        {"J", "E"},
        {"E", "D"},
        {"D", "I"}
      ]

    actual_minimum_orbit_transfers =
      minimum_orbit_transfers(transfer_object_ancestors, target_object_ancestors)

    assert actual_minimum_orbit_transfers == expected_minimum_orbit_transfers
  end



  test "minimum number of orbit transfers", context do
    assert minimum_number_of_orbit_transfers(context[:orbit_map], "YOU", "SAN") == 4
  end

  test "process input" do
    assert process_input() == 352
  end

end
