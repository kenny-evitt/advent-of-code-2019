defmodule AdventOfCode2019.Day3Puzzle1 do

  @central_port_position {0, 0}

  @type position          :: {integer, integer}
  @type direction         :: :up | :down | :left | :right
  @type wire_number       :: non_neg_integer
  @type wire_length_item  :: {:wire_length, wire_number, direction}
  @type wire_bend_item    :: {:wire_bend, wire_number}
  @type intersection_item :: :intersection
  @type panel_item        :: :central_port | wire_length_item | wire_bend_item | intersection_item
  @type panel_items       :: %{required(position) => panel_item}
  @type intersections     :: [position]

  @type panel             ::
  %{
    items: panel_items,
    wires_count: non_neg_integer,
    intersections: intersections
  }

  @spec new_front_panel() :: panel
  def new_front_panel() do
    %{
      items: %{
        @central_port_position => :central_port
      },
      wires_count: 0,
      intersections: []
    }
  end

  @spec new_front_panel([raw_wire]) :: panel
  def new_front_panel(raw_wires) do
    Enum.reduce(
      raw_wires,
      new_front_panel(),
      fn raw_wire, panel ->
        add_wire(
          panel,
          parse_raw_wire(raw_wire)
        )
      end
    )
  end


  @spec draw_front_panel(panel) :: [String.t]
  def draw_front_panel(panel) do
    panel_items = panel.items
    {{some_x, some_y}, _} = Enum.at(panel_items, 0)

    {min_x, max_x, min_y, max_y} =
      Enum.reduce(
        panel_items,
        {some_x, some_x, some_y, some_y},
        fn {{x, y}, _type}, {min_x, max_x, min_y, max_y} ->
          {
            min(min_x, x), max(max_x, x),
            min(min_y, y), max(max_y, y)
          }
        end
      )

    for y <- (max_y + 1)..(min_y - 1) do
      for x <- (min_x - 1)..(max_x + 1) do
        case Map.get(panel_items, {x, y}) do
          :central_port             -> "o"
          :intersection             -> "X"

          {:wire_length, _, :up}    -> "|"
          {:wire_length, _, :down}  -> "|"
          {:wire_length, _, :left}  -> "-"
          {:wire_length, _, :right} -> "-"

          {:wire_bend, _}           -> "+"
          nil                       -> "."
          _                         -> raise("Encountered an unknown point type; something went wrong.")
        end
      end
      |> List.to_string()
    end
  end


  def show(front_panel_drawing) do
    Enum.each(front_panel_drawing, &IO.puts/1)
  end

  @type raw_wire_path_movement :: String.t
  @type distance :: pos_integer
  @type wire_path_movement :: {direction, distance}


  @spec parse_wire_path_movement(raw_wire_path_movement) :: wire_path_movement
  def parse_wire_path_movement(movement_string) do
    regex = ~r/^(?<direction>[UDLR])(?<distance>\d+)$/
    captures = Regex.named_captures(regex, movement_string)

    {
      case captures["direction"] do
        "U" -> :up
        "D" -> :down
        "L" -> :left
        "R" -> :right
      end,
      String.to_integer(captures["distance"])
    }
  end


  @spec parse_wire_path([raw_wire_path_movement]) :: [wire_path_movement]
  def parse_wire_path(path) do
    Enum.map(path, &parse_wire_path_movement/1)
  end

  @type wire :: [wire_path_movement]

  @spec add_wire(panel, wire) :: panel
  def add_wire(panel, wire) do
    add_wire(
      panel,
      panel.wires_count + 1,
      @central_port_position,
      wire
    )
  end

  @spec new_position(position, direction) :: position
  def new_position({x, y} = _position, direction) do
    case direction do
      :up    -> {x,     y + 1}
      :down  -> {x,     y - 1}
      :left  -> {x - 1, y    }
      :right -> {x + 1, y    }
    end
  end


  @spec update_panel_position(panel, position, panel_item) :: panel
  def update_panel_position(panel, position, item) do
    item_wire_number =
      case item do
        {:wire_length, wire_number, _direction} -> wire_number
        {:wire_bend, wire_number}               -> wire_number
      end

    item_key = [:items, position]

    new_item =
      case get_in(panel, item_key) do
        :central_port -> :central_port
        {:wire_length, wire_number, _direction} ->
          if item_wire_number == wire_number, do: item, else: :intersection
        nil -> item
      end

    panel
    |> put_in(item_key, new_item)
    |> Map.update(
      :intersections,
      case new_item do
        :intersection -> [position]
        _             -> []
      end,
      fn intersections ->
        case new_item do
          :intersection -> [position | intersections]
          _             -> intersections
        end
      end
    )
  end


  @spec add_wire_segment(panel, wire_number, position, direction, panel_item, wire) :: panel
  def add_wire_segment(panel, wire_number, current_position, direction, item, wire_rest) do
    new_position = new_position(current_position, direction)

    update_panel_position(
      panel,
      new_position,
      item
    )
    |> add_wire(wire_number, new_position, wire_rest)
  end



  @spec add_wire(panel, wire_number, position, wire) :: panel
  def add_wire(panel, wire_number, current_position, wire)


  # Handle the last wire path movement:

  # Handle the end of the last wire path movement:
  def add_wire(panel, wire_number, _current_position, [{_direction, 0}]) do
    Map.put(panel, :wires_count, wire_number)
  end

  def add_wire(panel, wire_number, current_position, [{direction, distance}]) do
    add_wire_segment(
      panel,
      wire_number,
      current_position,
      direction,
      {:wire_length, wire_number, direction},
      [{direction, distance - 1}]
    )
  end

  # Handle the end of the current (and not-last) wire path movement:
  def add_wire(panel, wire_number, current_position, [{direction, 1} | wire_tail]) do
    add_wire_segment(
      panel,
      wire_number,
      current_position,
      direction,
      {:wire_bend, wire_number},
      wire_tail
    )
  end

  def add_wire(panel, wire_number, current_position, [{direction, distance} | wire_tail]) do
    add_wire_segment(
      panel,
      wire_number,
      current_position,
      direction,
      {:wire_length, wire_number, direction},
      [{direction, distance - 1} | wire_tail]
    )
  end



  @type raw_wire :: String.t

  @spec parse_raw_wire(raw_wire) :: [wire_path_movement]
  def parse_raw_wire(raw_wire) do
    raw_wire
    |> String.trim_trailing()
    |> String.split(",")
    |> parse_wire_path()
  end

  @spec manhattan_distance(position, position) :: non_neg_integer
  def manhattan_distance({0, 0}, {x, y}) do
    abs(x) + abs(y)
  end
  def manhattan_distance({x, y}, {0, 0}) do
    abs(x) + abs(y)
  end
  def manhattan_distance({x0, y0}, {x1, y1}) do
    abs(x0 - x1) + abs(y0 - y1)
  end


  @spec intersection_closest_to_central_port(panel) :: {position, non_neg_integer} | :no_intersections
  def intersection_closest_to_central_port(panel) do
    panel.intersections
    |> Enum.map(
      fn intersection ->
        {
          intersection, 
          manhattan_distance(@central_port_position, intersection)
        }
      end
    )
    |> Enum.min_by(
      fn {_intersection, distance} -> distance end,
      fn -> :no_intersections end
    )
  end


  def input_panel() do
    {:ok, input} = File.read("input/day-3-puzzle-1")

    input
    |> String.split()
    |> new_front_panel()
  end


  def process_input() do
    input_panel()
    |> intersection_closest_to_central_port()
  end


  def output_answer() do
    {_intersection, distance} = process_input()
    distance
  end
end
