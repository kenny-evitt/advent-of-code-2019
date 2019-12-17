defmodule AdventOfCode2019.Day8Puzzle2Test do
  use ExUnit.Case
  import AdventOfCode2019.Day8Puzzle2
  import ExUnit.CaptureIO


  setup_all do
    image =
      [
        [
          [0, 2],
          [2, 2],
        ],
        [
          [1, 1],
          [2, 2],
        ],
        [
          [2, 2],
          [1, 2],
        ],
        [
          [0, 0],
          [0, 0],
        ]
      ]

    {:ok, image: image}
  end


  test "decode", context do

    expected_layer =
      [
        [0, 1],
        [1, 0]
      ]

    assert decode(context.image) == expected_layer
  end


  test "show", context do
    expected_io =
      """
       +
      + 
      """

    assert capture_io(fn -> show(context.image) end) == expected_io
  end


  test "process input" do
    expected_io =
      """
      +++   ++  +  + +     ++  
      +  + +  + +  + +    +  + 
      +  + +    +  + +    +  + 
      +++  +    +  + +    ++++ 
      +    +  + +  + +    +  + 
      +     ++   ++  ++++ +  + 
      """

    assert capture_io(fn -> process_input() end) == expected_io
  end


end
