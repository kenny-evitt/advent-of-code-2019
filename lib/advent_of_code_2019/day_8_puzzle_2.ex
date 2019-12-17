defmodule AdventOfCode2019.Day8Puzzle2 do

  @type image       :: AdventOfCode2019.Day8Puzzle1.image
  @type image_layer :: AdventOfCode2019.Day8Puzzle1.image_layer

  @spec decode(image) :: image_layer
  def decode(image) do
    image
    |> Enum.map(&List.flatten/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&first_non_transparent_pixel/1)
    |> AdventOfCode2019.Day8Puzzle1.chunk_rows(
      width(image)
    )
  end

  @spec width(image) :: pos_integer
  def width(image) do
    image
    |> hd()     # First layer
    |> hd()     # First row
    |> length()
  end

  @type pixel :: AdventOfCode2019.Day8Puzzle1.image_pixel

  @spec first_non_transparent_pixel([pixel]) :: pixel
  def first_non_transparent_pixel(pixels) do
    Enum.find(pixels, &(&1 != 2))
  end

  @spec show(image) :: :ok
  def show(image) do
    decode(image)
    |> Enum.map(&row_to_strings/1)
    |> Enum.each(&IO.puts/1)
  end

  @type row :: AdventOfCode2019.Day8Puzzle1.image_layer_row

  @spec row_to_strings(row) :: String.t
  def row_to_strings(row) do
    Enum.map(
      row,
      fn pixel ->
        case pixel do
          0 -> " "
          1 -> "+"
        end
      end
    )
  end


  @spec process_input() :: :ok
  def process_input() do
    {:ok, input} = File.read("input/day-8-puzzle-1")

    input
    |> AdventOfCode2019.Day8Puzzle1.parse_image_data(25, 6)
    |> show()
  end


end
