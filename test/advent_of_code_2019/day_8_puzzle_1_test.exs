defmodule AdventOfCode2019.Day8Puzzle1Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  import AdventOfCode2019.Day8Puzzle1


  test "parse image data" do
    image_data_string = "123456789012"
    width = 3
    height = 2

    expected_image =
      [
        [
          [1, 2, 3],
          [4, 5, 6]
        ],
        [
          [7, 8, 9],
          [0, 1, 2]
        ]
      ]

    assert parse_image_data(image_data_string, width, height) == expected_image
  end


  test_with_params "count layer pixel colors",
    fn layer, color, expected_count ->
      flattened_layer = List.flatten(layer)
      assert count_pixels(flattened_layer, color) == expected_count
    end do
      [
        {
          [
            [1, 2, 3],
            [4, 5, 6]
          ],
          0,
          0
        },
        {
          [
            [1, 2, 3],
            [4, 5, 6]
          ],
          1,
          1
        },
        {
          [
            [1, 2, 3],
            [4, 5, 6]
          ],
          2,
          1
        },
        {
          [
            [7, 8, 9],
            [0, 1, 2]
          ],
          0,
          1
        },
        {
          [
            [7, 8, 9],
            [0, 1, 2]
          ],
          1,
          1
        },
        {
          [
            [7, 8, 9],
            [0, 1, 2]
          ],
          2,
          1
        }
      ]
  end


  test "find layer with fewest pixels by color example 1" do
    flattened_layers =
      [
        [1, 2, 3, 4, 5, 6],
        [7, 8, 9, 0, 1, 2]
      ]

    assert flattened_layer_with_fewest_pixels_by_color(flattened_layers, 0) == [1, 2, 3, 4, 5, 6]
  end


  test "find layer with fewest pixels by color example 2" do
    flattened_layers =
      [
        [1, 2, 3, 4, 5, 6],
        [7, 8, 9, 0, 1, 2]
      ]

    assert flattened_layer_with_fewest_pixels_by_color(flattened_layers, 3) == [7, 8, 9, 0, 1, 2]
  end


  test "find layer with fewest pixels by color example 3" do
    flattened_layers =
      [
        [1, 2, 3, 4, 5, 6],
        [7, 8, 9, 0, 1, 2]
      ]

    assert flattened_layer_with_fewest_pixels_by_color(flattened_layers, 7) == [1, 2, 3, 4, 5, 6]
  end


  # The following fails with an error like:
  #
  # ```
  # ** (BadArityError) #Function<0.7843691/3 in AdventOfCode2019.Day8Puzzle1Test."test 'find layer with fewest pixels by color': number of 0"/1> with arity 3 called with 6 arguments (1, 2, 3, 4, 5, 6)
  # ```
  #
  _ = """
  test_with_params "find layer with fewest pixels by color",
    fn flattened_layers, color, expected_flattened_layer ->
      actual_flattened_layer = flattened_layer_with_fewest_pixels_by_color(flattened_layers, color)
      assert actual_flattened_layer == expected_flattened_layer
    end do
      [
        {
          [
            [1, 2, 3, 4, 5, 6],
            [7, 8, 9, 0, 1, 2]
          ],
          0,
          [1, 2, 3, 4, 5, 6]
        },
        {
          [
            [1, 2, 3, 4, 5, 6],
            [7, 8, 9, 0, 1, 2]
          ],
          3,
          [7, 8, 9, 0, 1, 2]
        },
        {
          [
            [1, 2, 3, 4, 5, 6],
            [7, 8, 9, 0, 1, 2]
          ],
          7,
          [1, 2, 3, 4, 5, 6]
        },
      ]
  end
  """

  test "process input" do
    assert process_input() == 1920
  end

end
