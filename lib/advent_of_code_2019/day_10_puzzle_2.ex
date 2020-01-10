defmodule AdventOfCode2019.Day10Puzzle2 do

  @type raw_map      :: AdventOfCode2019.Day10Puzzle1.raw_map
  @type asteroid_map :: AdventOfCode2019.Day10Puzzle1.asteroid_map
  @type position     :: AdventOfCode2019.Day10Puzzle1.position


  @spec parse_raw_map(raw_map) :: {asteroid_map, position}
  def parse_raw_map(raw_map) do
    {asteroid_map, laser_position} =
      raw_map
      |> String.trim_trailing() # Trim, e.g. newline, character(s)
      |> String.split()
      |> Enum.with_index()
      |> Enum.reduce(
        {%{}, nil},
        fn {row, y}, {asteroid_map, laser_position} ->
          {row_asteroid_map, row_laser_position} = parse_raw_map_row({row, y})

          if not is_nil(row_laser_position) and not is_nil(laser_position) do
            raise("There are multiple lasers!")
          else
            {
              Map.merge(asteroid_map, row_asteroid_map),
              if is_nil(laser_position) do
                row_laser_position
              else
                laser_position
              end
            }
          end
        end
      )

    if is_nil(laser_position) do
      # 'Add' laser:

      {laser_position, _dectectable_asteroid_count} =
        AdventOfCode2019.Day10Puzzle1.best_monitoring_station_location(asteroid_map)

      {
        asteroid_map |> Map.drop([laser_position]),
        laser_position
      }
    else
      {asteroid_map, laser_position}
    end
  end


  @type position_component :: AdventOfCode2019.Day10Puzzle1.position_component


  @spec parse_raw_map_row({String.t, position_component}) :: {asteroid_map, position | nil}
  def parse_raw_map_row({raw_map_row, y}) do
    raw_map_row
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(
      {%{}, nil},
      fn {map_character, x}, {asteroid_map, laser_position} ->
        cond do
          map_character == "#" ->
            {
              Map.put(asteroid_map, {x, y}, true),
              laser_position
            }

          map_character == "X" and not is_nil(laser_position) ->
            raise("There are multiple lasers (with the same `y` position)!")

          map_character == "X" and is_nil(laser_position) ->
            {
              asteroid_map,
              {x, y}
            }

          true -> {asteroid_map, laser_position}
        end
      end
    )
  end


  @spec vaporize(asteroid_map, position) :: [position]
  def vaporize(asteroid_map, laser_position) do
    positions_and_distances_grouped_by_angle =
      Map.keys(asteroid_map)
      |> Enum.map(&({&1, angle_and_distance(laser_position, &1)}))
      |> Enum.group_by(
        fn {_position, {angle, _distance}} -> angle end,
        fn {position, {_angle, distance}} -> {position, distance} end
      )

    sorted_list_of_lists_of_positions =
      Map.keys(positions_and_distances_grouped_by_angle)
      |> Enum.sort(&compare_angles/2)
      |> Enum.map(
        fn angle ->
          positions_and_distances_grouped_by_angle[angle]
          |> Enum.sort(
            fn {_position1, distance1}, {_position2, distance2} ->
              distance1 <= distance2
            end
          )
          |> Enum.map(fn {position, _distance} -> position end)
        end
      )

    vaporize_(sorted_list_of_lists_of_positions, [])
  end


  @spec vaporize_([[position]], [position]) :: [position]
  def vaporize_(sorted_list_of_lists_of_positions, vaporized_asteroid_positions)

  def vaporize_([], vaporized_asteroid_positions) do
    Enum.reverse(vaporized_asteroid_positions)
  end

  def vaporize_(sorted_list_of_lists_of_positions, vaporized_asteroid_positions) do
    {new_list_of_lists, new_vaporized_asteroid_positions} =
      Enum.reduce(
        sorted_list_of_lists_of_positions,
        {[], vaporized_asteroid_positions},
        fn [position | rest], {new_list_of_lists, new_vaporized_asteroid_positions} ->
          {
            (if rest == [], do: new_list_of_lists, else: [rest | new_list_of_lists]),
            [position | new_vaporized_asteroid_positions]
          }
        end
      )

    vaporize_(
      Enum.reverse(new_list_of_lists),
      new_vaporized_asteroid_positions
    )
  end


  @type angle              :: {integer, integer}
  @type distance           :: pos_integer
  @type angle_and_distance :: {angle, distance}


  @spec angle_and_distance(position, position) :: angle_and_distance
  def angle_and_distance({x1, y1}, {x2, y2}) do
    dx = x2 - x1
    dy = y2 - y1

    cond do
      dx == 0 and dy == 0 ->
        raise("Same position!")

      dx == 0 ->
        if dy > 0 do
          {{dx,  1}, dy         }
        else
          {{dx, -1}, div(dy, -1)}
        end

      dy == 0 ->
        if dx > 0 do
          {{ 1, dy}, dx         }
        else
          {{-1, dy}, div(dx, -1)}
        end
      
      true ->
        d_gcd = Integer.gcd(dx, dy)
        {
          {
            div(dx, d_gcd),
            div(dy, d_gcd)
          },
          d_gcd
        }
    end
  end


  @doc """
  For use with `Enum.sort/2`
  """
  @spec compare_angles(angle, angle) :: boolean
  def compare_angles({dx1, dy1} = angle1, {dx2, dy2} = angle2) do

    cond do
      angle1 == angle2 -> true

      # In the comments below, 'up' is towards negative infinity 'y' position components;
      # 'right' is towards positive infinity 'x' position components.

      # Note that the conditions below only work in the following specific order:

      # Up:
      (dx1 == 0 and dy1 == -1) and (dx2 != 0 or dy2 != -1) -> true
      (dx2 == 0 and dy2 == -1) and (dx1 != 0 or dy1 != -1) -> false

      # Up-right:
      (dx1 > 0 and dy1 < 0) and (dx2 <= 0 or dy2 >= 0) -> true
      (dx2 > 0 and dy2 < 0) and (dx1 <= 0 or dy1 >= 0) -> false

      # Right:
      (dx1 > 0 and dy1 == 0) and (dx2 <= 0 or dy2 != 0) -> true
      (dx2 > 0 and dy2 == 0) and (dx1 <= 0 or dy1 != 0) -> false

      # Right-down:
      (dx1 > 0 and dy1 > 0) and (dx2 <= 0 or dy2 <= 0) -> true
      (dx2 > 0 and dy2 > 0) and (dx1 <= 0 or dy1 <= 0) -> false

      # Down:
      (dx1 == 0 and dy1 == 1) and dx2 != 0 -> true
      (dx2 == 0 and dy2 == 1) and dx1 != 0 -> false

      # Down-left:
      (dx1 < 0 and dy1 > 0) and dy2 <= 0 -> true
      (dx2 < 0 and dy2 > 0) and dy1 <= 0 -> false

      # Left:
      (dx1 == -1 and dy1 == 0) and dy2 <= 0 -> true
      (dx2 == -1 and dy2 == 0) and dy1 <= 0 -> false

      # Compare angles within the same quadrant:
      true ->
        ( angle_sign(angle1) * abs(dx1) * abs(dy2) ) >= ( angle_sign(angle2) * abs(dx2) * abs(dy1) )
    end
  end


  @spec angle_sign(angle) :: 1 | -1
  def angle_sign({dx, dy}) do
    cond do
      dx > 0 and dy > 0 ->  1
      dx < 0 and dy < 0 ->  1
      true              -> -1
    end
  end

  def process_input() do
    {:ok, raw_map} = File.read("input/day-10")
    {asteroid_map, laser_position} = parse_raw_map(raw_map)

    vaporize(asteroid_map, laser_position)
    |> Enum.at(200 - 1)
    |> (fn {x, y} -> (100 * x) + y end).()
  end

end
