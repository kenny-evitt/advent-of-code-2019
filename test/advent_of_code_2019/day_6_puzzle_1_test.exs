defmodule AdventOfCode2019.Day6Puzzle1Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  import AdventOfCode2019.Day6Puzzle1

  test_with_params "parse orbit strings",
    fn orbit_string, expected_object_names ->
      assert parse_orbit(orbit_string) == expected_object_names
    end do
      [
        {"AAA)BBB", {"AAA", "BBB"}},
        {"COM)B",   {"COM", "B"  }},
        {  "B)C",   {"B",   "C"  }},
        {  "C)D",   {"C",   "D"  }},
        {  "D)E",   {"D",   "E"  }},
        {  "E)F",   {"E",   "F"  }},
        {  "B)G",   {"B",   "G"  }},
        {  "G)H",   {"G",   "H"  }},
        {  "D)I",   {"D",   "I"  }},
        {  "E)J",   {"E",   "J"  }},
        {  "J)K",   {"J",   "K"  }},
        {  "K)L",   {"K",   "L"  }},
        {"J1C)J1M", {"J1C", "J1M"}}
      ]
  end


  test "parse orbit map" do
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
      """

    expected_parsed_orbit_map_children =
      %{
        "COM" => ["B"],
        "B"   => ["G", "C"],
        "C"   => ["D"],
        "D"   => ["I", "E"],
        "E"   => ["J", "F"],
        "G"   => ["H"],
        "J"   => ["K"],
        "K"   => ["L"]
      }

    assert parse_orbit_map(orbit_map_string).children == expected_parsed_orbit_map_children
  end


  test "count orbits example 0" do
    orbit_map =
      %{
        children: %{
          "COM" => ["B"],
          "B"   => ["G", "C"],
          "C"   => ["D"],
          "D"   => ["I", "E"],
          "E"   => ["J", "F"],
          "G"   => ["H"],
          "J"   => ["K"],
          "K"   => ["L"]
        },
        parents: %{}
      }

    assert count_orbits(orbit_map) == {11, 31}
  end


  test "count orbits example 1" do
    orbit_map = %{children: %{}, parents: %{}}
    assert count_orbits(orbit_map) == {0, 0}
  end


  test "count orbits example 2" do
    orbit_map =
      %{
        children: %{
          "COM" => ["B"]
        },
        parents: %{}
      }

    assert count_orbits(orbit_map) == {1, 0}
  end


end
