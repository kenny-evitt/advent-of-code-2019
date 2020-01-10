defmodule AdventOfCode2019.Day10Puzzle2Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  import AdventOfCode2019.Day10Puzzle2



  test "parse raw map with laser" do
    raw_map =
      """
      .#....#####...#..
      ##...##.#####..##
      ##...#...#.#####.
      ..#.....X...###..
      ..#.#.....#....##
      """


    expected_asteroid_map =
      %{
        { 1, 0} => true,
        { 6, 0} => true,
        { 7, 0} => true,
        { 8, 0} => true,
        { 9, 0} => true,
        {10, 0} => true,
        {14, 0} => true,

        { 0, 1} => true,
        { 1, 1} => true,
        { 5, 1} => true,
        { 6, 1} => true,
        { 8, 1} => true,
        { 9, 1} => true,
        {10, 1} => true,
        {11, 1} => true,
        {12, 1} => true,
        {15, 1} => true,
        {16, 1} => true,

        { 0, 2} => true,
        { 1, 2} => true,
        { 5, 2} => true,
        { 9, 2} => true,
        {11, 2} => true,
        {12, 2} => true,
        {13, 2} => true,
        {14, 2} => true,
        {15, 2} => true,

        { 2, 3} => true,
        {12, 3} => true,
        {13, 3} => true,
        {14, 3} => true,

        { 2, 4} => true,
        { 4, 4} => true,
        {10, 4} => true,
        {15, 4} => true,
        {16, 4} => true
      }


    {actual_asteroid_map, actual_laser_position} = parse_raw_map(raw_map)

    assert actual_asteroid_map == expected_asteroid_map
    assert actual_laser_position == {8, 3}
  end



  test_with_params "parse raw map row",
    fn raw_map_row, row_y, expected_parsed_output ->
      assert parse_raw_map_row({raw_map_row, row_y}) == expected_parsed_output
    end do
      [
        {
          ".#....#####...#..",
          0,
          {
            %{
              { 1, 0} => true,
              { 6, 0} => true,
              { 7, 0} => true,
              { 8, 0} => true,
              { 9, 0} => true,
              {10, 0} => true,
              {14, 0} => true
            },
            nil
          }
        },
        {
          "..#.....X...###..",
          3,
          {
            %{
              { 2, 3} => true,
              {12, 3} => true,
              {13, 3} => true,
              {14, 3} => true
            },
            {8, 3}
          }
        }
      ]
  end


  test "vaporize example 1" do
    raw_map =
      """
      .#....#####...#..
      ##...##.#####..##
      ##...#...#.#####.
      ..#.....X...###..
      ..#.#.....#....##
      """

    {asteroid_map, laser_position} = parse_raw_map(raw_map)

    expected_vaporize =
      [
        { 8, 1},
        { 9, 0},
        { 9, 1},
        {10, 0},
        { 9, 2},
        {11, 1},
        {12, 1},
        {11, 2},
        {15, 1},

        {12, 2},
        {13, 2},
        {14, 2},
        {15, 2},
        {12, 3},
        {16, 4},
        {15, 4},
        {10, 4},
        { 4, 4},

        { 2, 4},
        { 2, 3},
        { 0, 2},
        { 1, 2},
        { 0, 1},
        { 1, 1},
        { 5, 2},
        { 1, 0},
        { 5, 1},

        { 6, 1},
        { 6, 0},
        { 7, 0},
        { 8, 0},
        {10, 1},
        {14, 0},
        {16, 1},
        {13, 3},
        {14, 3}
      ]

    assert vaporize(asteroid_map, laser_position) == expected_vaporize
  end


  test "vaporize example 2" do
    raw_map =
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
      """

    {asteroid_map, laser_position} = parse_raw_map(raw_map)

    assert laser_position == {11, 13}

    vaporized_asteroid_positions = vaporize(asteroid_map, laser_position)

    assert Enum.at(vaporized_asteroid_positions,   1 - 1) == {11, 12}
    assert Enum.at(vaporized_asteroid_positions,   2 - 1) == {12,  1}
    assert Enum.at(vaporized_asteroid_positions,   3 - 1) == {12,  2}
    assert Enum.at(vaporized_asteroid_positions,  10 - 1) == {12,  8}
    assert Enum.at(vaporized_asteroid_positions,  20 - 1) == {16,  0}
    assert Enum.at(vaporized_asteroid_positions,  50 - 1) == {16,  9}
    assert Enum.at(vaporized_asteroid_positions, 100 - 1) == {10, 16}
    assert Enum.at(vaporized_asteroid_positions, 199 - 1) == { 9,  6}
    assert Enum.at(vaporized_asteroid_positions, 200 - 1) == { 8,  2}
    assert Enum.at(vaporized_asteroid_positions, 201 - 1) == {10,  9}
    assert Enum.at(vaporized_asteroid_positions, 299 - 1) == {11,  1}
  end


  test_with_params "angle and distance",
    fn position1, position2, expected_angle_and_distance ->
      assert angle_and_distance(position1, position2) == expected_angle_and_distance
    end do
      [
        {
          {8, 3},
          {8, 1},
          {{0, -1}, 2}
        },
        {
          {8, 3},
          {9, 0},
          {{1, -3}, 1}
        }
      ]
  end

  test_with_params "compare angles",
    fn angle_1, angle_2, expected_compare ->
      actual_compare = compare_angles(angle_1, angle_2)
      assert actual_compare == expected_compare
    end do
      [
        "up vs up-right": {
          {  0,  -1},
          {  2,  -3},
          true
        },
        "up vs right": {
          {  0,  -1},
          {  1,   0},
          true
        },
        "up vs right-down": {
          {  0,  -1},
          {  7,  11},
          true
        },
        "up vs down": {
          {  0,  -1},
          {  0,   1},
          true
        },
        "up vs down-left": {
          {  0,  -1},
          {-17,  19},
          true
        },
        "up vs left": {
          {  0,  -1},
          { -1,   0},
          true
        },
        "up vs left-up": {
          {  0,  -1},
          {-29, -31},
          true
        },

        "up-right vs up": {
          {  2,  -3},
          {  0,  -1},
          false
        },
        "up-right vs right": {
          {  2,  -3},
          {  1,   0},
          true
        },
        "up-right vs right-down": {
          {  2,  -3},
          {  7,  11},
          true
        },
        "up-right vs down": {
          {  2,  -3},
          {  0,   1},
          true
        },
        "up-right vs down-left": {
          {  2,  -3},
          {-17,  19},
          true
        },
        "up-right vs left": {
          {  2,  -3},
          { -1,   0},
          true
        },
        "up-right vs left-up": {
          {  2,  -3},
          {-29, -31},
          true
        },

        "right vs up": {
          {  1,   0},
          {  0,  -1},
          false
        },
        "right vs up-right": {
          {  1,   0},
          {  2,  -3},
          false
        },
        "right vs right-down": {
          {  1,   0},
          {  7,  11},
          true
        },
        "right vs down": {
          {  1,   0},
          {  0,   1},
          true
        },
        "right vs down-left": {
          {  1,   0},
          {-17,  19},
          true
        },
        "right vs left": {
          {  1,   0},
          { -1,   0},
          true
        },
        "right vs left-up": {
          {  1,   0},
          {-29, -31},
          true
        },

        "right-down vs up": {
          {  7,  11},
          {  0,  -1},
          false
        },
        "right-down vs up-right": {
          {  7,  11},
          {  2,  -3},
          false
        },
        "right-down vs right": {
          {  7,  11},
          {  1,   0},
          false
        },
        "right-down vs down": {
          {  7,  11},
          {  0,   1},
          true
        },
        "right-down vs down-left": {
          {  7,  11},
          {-17,  19},
          true
        },
        "right-down vs left": {
          {  7,  11},
          { -1,   0},
          true
        },
        "right-down vs left-up": {
          {  7,  11},
          {-29, -31},
          true
        },

        "down vs up": {
          {  0,   1},
          {  0,  -1},
          false
        },
        "down vs up-right": {
          {  0,   1},
          {  2,  -3},
          false
        },
        "down vs right": {
          {  0,   1},
          {  1,   0},
          false
        },
        "down vs right-down": {
          {  0,   1},
          {  7,  11},
          false
        },
        "down vs down-left": {
          {  0,   1},
          {-17,  19},
          true
        },
        "down vs left": {
          {  0,   1},
          { -1,   0},
          true
        },
        "down vs left-up": {
          {  0,   1},
          {-29, -31},
          true
        },

        "down-left vs up": {
          {-17,  19},
          {  0,  -1},
          false
        },
        "down-left vs up-right": {
          {-17,  19},
          {  2,  -3},
          false
        },
        "down-left vs right": {
          {-17,  19},
          {  1,   0},
          false
        },
        "down-left vs right-down": {
          {-17,  19},
          {  7,  11},
          false
        },
        "down-left vs down": {
          {-17,  19},
          {  0,   1},
          false
        },
        "down-left vs left": {
          {-17,  19},
          { -1,   0},
          true
        },
        "down-left vs left-up": {
          {-17,  19},
          {-29, -31},
          true
        },

        "left vs up": {
          { -1,   0},
          {  0,  -1},
          false
        },
        "left vs up-right": {
          { -1,   0},
          {  2,  -3},
          false
        },
        "left vs right": {
          { -1,   0},
          {  1,   0},
          false
        },
        "left vs right-down": {
          { -1,   0},
          {  7,  11},
          false
        },
        "left vs down": {
          { -1,   0},
          {  0,   1},
          false
        },
        "left vs down-left": {
          { -1,   0},
          {-17,  19},
          false
        },
        "left vs left-up": {
          { -1,   0},
          {-29, -31},
          true
        },

        "up-right vs up-right 1": {
          { 2, -3},
          { 3, -2},
          true
        },
        "up-right vs up-right 2": {
          { 7, -5},
          { 5, -7},
          false
        },
        "right-down vs right-down 1": {
          { 3,  2},
          { 2,  3},
          true
        },
        "right-down vs right-down 2": {
          { 5,  7},
          { 7,  5},
          false
        },
        "down-left vs down-left 1": {
          {-2,  3},
          {-3,  2},
          true
        },
        "down-left vs down-left 2": {
          {-7,  5},
          {-5,  7},
          false
        },
        "left-up vs left-up 1": {
          {-3, -2},
          {-2, -3},
          true
        },
        "left-up vs left-up 2": {
          {-5, -7},
          {-7, -5},
          false
        }
      ]
  end

end
