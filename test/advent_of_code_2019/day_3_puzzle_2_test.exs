defmodule AdventOfCode2019.Day3Puzzle2Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  import AdventOfCode2019.Day3Puzzle1
  import AdventOfCode2019.Day3Puzzle2



  test "find intersection with minimal signal delay, example 1" do
    raw_wires =
      [
        "R8,U5,L5,D3",
        "U7,R6,D4,L4"
      ]

    expected_intersection_and_wire_steps = {{6, 5}, 30, [{2, 15}, {1, 15}]}

    panel = new_front_panel(raw_wires)
    actual_intersection_and_wire_steps = minimal_signal_delay_intersection(panel)
    assert actual_intersection_and_wire_steps == expected_intersection_and_wire_steps
  end



  test "find intersection with minimal signal delay, example 2" do
    raw_wires =
      [
        "R75,D30,R83,U83,L12,D49,R71,U7,L72",
        "U62,R66,U55,R34,D71,R55,D58,R83"
      ]

    expected_intersection_and_wire_steps = {{158, -12}, 610, [{2, 404}, {1, 206}]}

    panel = new_front_panel(raw_wires)
    actual_intersection_and_wire_steps = minimal_signal_delay_intersection(panel)
    assert actual_intersection_and_wire_steps == expected_intersection_and_wire_steps
  end



  test "find intersection with minimal signal delay, example 3" do
    raw_wires =
      [
        "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
        "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
      ]

    expected_intersection_and_wire_steps = {{107, 47}, 410, [{2, 256}, {1, 154}]}

    panel = new_front_panel(raw_wires)
    actual_intersection_and_wire_steps = minimal_signal_delay_intersection(panel)
    assert actual_intersection_and_wire_steps == expected_intersection_and_wire_steps
  end





  # This doesn't compile; see:
  #
  #  - ["invalid quoted expression" compile error for a tuple value containing a list · Issue #35 · KazuCocoa/ex_parameterized](https://github.com/KazuCocoa/ex_parameterized/issues/35)
  #
  _ = """
  test_with_params "find intersection with minimal signal delay",
    fn raw_wires, expected_intersection_and_wire_steps ->
      panel = new_front_panel(raw_wires)
      actual_intersection_and_wire_steps = minimal_signal_delay_intersection(panel)
      assert actual_intersection_and_wire_steps == expected_intersection_and_wire_steps
    end do
      [
        {
          [
            "R8,U5,L5,D3",
            "U7,R6,D4,L4"
          ],
          {{6, 5}, 30, [{2, 15}, {1, 15}]}
        },
        {
          [
            "R75,D30,R83,U83,L12,D49,R71,U7,L72",
            "U62,R66,U55,R34,D71,R55,D58,R83"
          ],
          {{0, 0}, 610, []} # TODO: Update position and wire-number-and-steps list.
        },
        {
          [
            "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
            "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
          ],
          {{0, 0}, 410, []} # TODO: Update position and wire-number-and-steps list.
        }
      ]
  end
  """


  test "output answer" do
    assert AdventOfCode2019.Day3Puzzle2.output_answer() == 10554
  end

end
