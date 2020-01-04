defmodule AdventOfCode2019.Day10Puzzle1Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  import AdventOfCode2019.Day10Puzzle1


  test "parse raw map" do
    raw_map =
      """
      .#..#
      .....
      #####
      ....#
      ...##
      """

    expected_parsed_output =
      %{
        {1, 0} => true,
        {4, 0} => true,
        {0, 2} => true,
        {1, 2} => true,
        {2, 2} => true,
        {3, 2} => true,
        {4, 2} => true,
        {4, 3} => true,
        {3, 4} => true,
        {4, 4} => true
      }

    assert parse_raw_map(raw_map) == expected_parsed_output
  end


  test_with_params "parse raw map row",
    fn raw_map_row, row_y, expected_parsed_output ->
      assert parse_raw_map_row({raw_map_row, row_y}) == expected_parsed_output
    end do
      [
        {
          ".#..#",
          0,
          %{
            {1, 0} => true,
            {4, 0} => true
          }
        },
        {
          ".....",
          1,
          %{}
        },
        {
          "#####",
          2,
          %{
            {0, 2} => true,
            {1, 2} => true,
            {2, 2} => true,
            {3, 2} => true,
            {4, 2} => true
          }
        },
        {
          "....#",
          3,
          %{
            {4, 3} => true
          }
        },
        {
          "...##",
          4,
          %{
            {3, 4} => true,
            {4, 4} => true
          }
        }
      ]
  end


  test "line of sight" do
    raw_map =
      """
      .#..#
      .....
      #####
      ....#
      ...##
      """

    asteroid_map = parse_raw_map(raw_map)

    assert line_of_sight?(asteroid_map, {3, 4}, {1, 0}) == false

    assert line_of_sight?(asteroid_map, {3, 4}, {4, 0}) == true
    assert line_of_sight?(asteroid_map, {3, 4}, {0, 2}) == true
    assert line_of_sight?(asteroid_map, {3, 4}, {1, 2}) == true
    assert line_of_sight?(asteroid_map, {3, 4}, {2, 2}) == true
    assert line_of_sight?(asteroid_map, {3, 4}, {3, 2}) == true
    assert line_of_sight?(asteroid_map, {3, 4}, {4, 2}) == true
    assert line_of_sight?(asteroid_map, {3, 4}, {4, 3}) == true
    assert line_of_sight?(asteroid_map, {3, 4}, {4, 4}) == true
  end


  test "detectable asteroids" do
    raw_map =
      """
      .#..#
      .....
      #####
      ....#
      ...##
      """

    asteroid_map = parse_raw_map(raw_map)
    
    expected_detectable_asteroids =
      [
        {4, 0},
        {0, 2},
        {1, 2},
        {2, 2},
        {3, 2},
        {4, 2},
        {4, 3},
        {4, 4}
      ]

    assert(
      Enum.sort(
        detectable_asteroids(asteroid_map, {3, 4})
      )
      == Enum.sort(expected_detectable_asteroids)
    )
  end


  test_with_params "best monitoring station location",
    fn raw_map, expected_best_location_and_dectectable_asteroid_count ->
      asteroid_map = parse_raw_map(raw_map)

      assert(
        best_monitoring_station_location(asteroid_map) ==
          expected_best_location_and_dectectable_asteroid_count
      )
    end do
      [
        {
          """
          .#..#
          .....
          #####
          ....#
          ...##
          """,
          {{3, 4}, 8}
        },
        {
          """
          ......#.#.
          #..#.#....
          ..#######.
          .#.#.###..
          .#..#.....
          ..#....#.#
          #..#....#.
          .##.#..###
          ##...#..#.
          .#....####
          """,
          {{5, 8}, 33}
        },
        {
          """
          #.#...#.#.
          .###....#.
          .#....#...
          ##.#.#.#.#
          ....#.#.#.
          .##..###.#
          ..#...##..
          ..##....##
          ......#...
          .####.###.
          """,
          {{1, 2}, 35}
        },
        {
          """
          .#..#..###
          ####.###.#
          ....###.#.
          ..###.##.#
          ##.##.#.#.
          ....###..#
          ..#.#..#.#
          #..#.#.###
          .##...##.#
          .....#.#..
          """,
          {{6, 3}, 41}
        },
        {
          """
          .#..##.###...#######
          ##.############..##.
          .#.######.########.#
          .###.#######.####.#.
          #####.##.#.##.###.##
          ..#####..#.#########
          ####################
          #.####....###.#.#.##
          ##.#################
          #####.##.###..####..
          ..######..##.#######
          ####.##.####...##..#
          .#####..#.######.###
          ##...#.##########...
          #.##########.#######
          .####.#.###.###.#.##
          ....##.##.###..#####
          .#.#.###########.###
          #.#.#.#####.####.###
          ###.##.####.##.#..##
          """,
          {{11, 13}, 210}
        }
      ]
  end


end
