defmodule AdventOfCode2019.Day8Puzzle1 do

  @type color           :: 0..9
  @type image_pixel     :: color
  @type image_layer_row :: [image_pixel]
  @type image_layer     :: [image_layer_row]
  @type image           :: [image_layer]


  @spec parse_image_data(String.t, pos_integer, pos_integer) :: image
  def parse_image_data(image_data_string, width, height) do
    image_data_string
    |> String.trim_trailing() # Trim, e.g. newline, character(s)
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> chunk_layers(width * height)
    |> Enum.map(&(chunk_rows(&1, width)))
  end


  @spec chunk_layers([image_pixel], pos_integer) :: [[image_pixel]]
  def chunk_layers(pixels, pixels_per_layer) do
    Enum.chunk_every(pixels, pixels_per_layer)
  end

  @spec chunk_rows([image_pixel], pos_integer) :: image_layer
  def chunk_rows(pixels, pixels_per_row) do
    Enum.chunk_every(pixels, pixels_per_row)
  end

  @type flattened_layer :: [image_pixel]

  @spec count_pixels(flattened_layer, color) :: non_neg_integer
  def count_pixels(flattened_layer, color) do
    Enum.count(flattened_layer, &(&1 == color))
  end

  @spec flattened_layer_with_fewest_pixels_by_color([flattened_layer], color) :: flattened_layer
  def flattened_layer_with_fewest_pixels_by_color(flattened_layers, color) do
    Enum.min_by(
      flattened_layers,
      &(count_pixels(&1, color))
    )
  end


  @spec process_input() :: pos_integer
  def process_input() do
    {:ok, input} = File.read("input/day-8-puzzle-1")
    image = parse_image_data(input, 25, 6)

    flattened_layer_with_fewest_zero_pixels =
      image
      |> Enum.map(&List.flatten/1)
      |> flattened_layer_with_fewest_pixels_by_color(0)

    count_pixels(flattened_layer_with_fewest_zero_pixels, 1)
    * count_pixels(flattened_layer_with_fewest_zero_pixels, 2)
  end


end
