defmodule AdventOfCode2019.Day3Puzzle1Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  import AdventOfCode2019.Day3Puzzle1
  import ExUnit.CaptureIO


  test "draw front panel with central port only" do
    expected_drawing =
      [
        "...",
        ".o.",
        "..."
      ]

    assert draw_front_panel(new_front_panel()) == expected_drawing
  end


  test "show new front panel drawing" do
    drawing = draw_front_panel(new_front_panel())

    expected_io =
      """
      ...
      .o.
      ...
      """

    assert capture_io(fn -> show(drawing) end) == expected_io
  end


  test "show front panel drawing example 1" do
    raw_wires =
      [
        "R8,U5,L5,D3",
        "U7,R6,D4,L4"
      ]

    drawing =
      draw_front_panel(
        new_front_panel(raw_wires)
      )

    expected_io =
      """
      ...........
      .+-----+...
      .|.....|...
      .|..+--X-+.
      .|..|..|.|.
      .|.-X--+.|.
      .|..|....|.
      .|.......|.
      .o-------+.
      ...........
      """

    assert capture_io(fn -> show(drawing) end) == expected_io
  end


  test_with_params "parse wire path movements",
    fn raw_movement, expected_parsed_movement ->
      assert parse_wire_path_movement(raw_movement) == expected_parsed_movement
    end do
      [
        {"R8", {:right, 8}},
        {"U5", {:up,    5}},
        {"L5", {:left,  5}},
        {"D3", {:down,  3}}
      ]
  end

  test "parse wire path example 1" do
    path = ["R8", "U5", "L5", "D3"]
    expected_wire = [{:right, 8}, {:up, 5}, {:left, 5}, {:down, 3}]
    assert parse_wire_path(path) == expected_wire
  end


  test "add wire to panel example -1" do
    wire = [{:right, 1}]

    expected_panel = %{
      items: %{
        {0, 0} => :central_port,
        {1, 0} => {:wire_length, 1, 1, :right}
      },
      wires_count: 1,
      intersections: %{}
    }

    assert add_wire(new_front_panel(), wire) == expected_panel
  end


  test "add wire to panel example 0" do
    wire = [{:right, 8}]

    expected_panel = %{
      items: %{
        {0, 0} => :central_port,

        {1, 0} => {:wire_length, 1, 1, :right},
        {2, 0} => {:wire_length, 1, 2, :right},
        {3, 0} => {:wire_length, 1, 3, :right},
        {4, 0} => {:wire_length, 1, 4, :right},
        {5, 0} => {:wire_length, 1, 5, :right},
        {6, 0} => {:wire_length, 1, 6, :right},
        {7, 0} => {:wire_length, 1, 7, :right},
        {8, 0} => {:wire_length, 1, 8, :right}
      },
      wires_count: 1,
      intersections: %{}
    }

    assert add_wire(new_front_panel(), wire) == expected_panel
  end



  test "add wire to panel example 1" do
    wire = [{:right, 8}, {:up, 5}, {:left, 5}, {:down, 3}]

    expected_panel = %{
      items: %{
        {0, 0} => :central_port,


        {1, 0} => {:wire_length, 1,  1, :right},
        {2, 0} => {:wire_length, 1,  2, :right},
        {3, 0} => {:wire_length, 1,  3, :right},
        {4, 0} => {:wire_length, 1,  4, :right},
        {5, 0} => {:wire_length, 1,  5, :right},
        {6, 0} => {:wire_length, 1,  6, :right},
        {7, 0} => {:wire_length, 1,  7, :right},

        {8, 0} => {:wire_bend,   1,  8},

        {8, 1} => {:wire_length, 1,  9, :up},
        {8, 2} => {:wire_length, 1, 10, :up},
        {8, 3} => {:wire_length, 1, 11, :up},
        {8, 4} => {:wire_length, 1, 12, :up},

        {8, 5} => {:wire_bend,   1, 13},

        {7, 5} => {:wire_length, 1, 14, :left},
        {6, 5} => {:wire_length, 1, 15, :left},
        {5, 5} => {:wire_length, 1, 16, :left},
        {4, 5} => {:wire_length, 1, 17, :left},

        {3, 5} => {:wire_bend,   1, 18},

        {3, 4} => {:wire_length, 1, 19, :down},
        {3, 3} => {:wire_length, 1, 20, :down},
        {3, 2} => {:wire_length, 1, 21, :down}
      },
      wires_count: 1,
      intersections: %{}
    }

    assert add_wire(new_front_panel(), wire) == expected_panel
  end



  test "add wire to panel example 2" do
    wire = [{:right, 4}, {:up, 2}, {:left, 2}, {:down, 3}]

    expected_panel = %{
      items: %{
        {0,  0} => :central_port,


        {1,  0} => {:wire_length, 1,  1, :right},
       #{2,  0} => {:wire_length, 1,  2, :right},
        {3,  0} => {:wire_length, 1,  3, :right},

        {4,  0} => {:wire_bend,   1,  4},

        {4,  1} => {:wire_length, 1,  5, :up},

        {4,  2} => {:wire_bend,   1,  6},

        {3,  2} => {:wire_length, 1,  7, :left},

        {2,  2} => {:wire_bend,   1,  8},

        {2,  1} => {:wire_length, 1,  9, :down},
       #{2,  0} => {:wire_length, 1, 10, :down},
        {2, -1} => {:wire_length, 1, 11, :down},

        # Self-intersection:
        {2,  0} => [
                   {:wire_length, 1, 10, :down},
                   {:wire_length, 1,  2, :right}
        ]
      },
      wires_count: 1,
      intersections: %{}
    }

    assert add_wire(new_front_panel(), wire) == expected_panel
  end



  test "add two wires to panel example 1" do
    wire1 = [{:right, 1}]
    wire2 = [{:up, 1}, {:right, 1}, {:down, 1}]

    expected_panel = %{
      items: %{
        {0, 0} => :central_port,


       #{1, 0} => {:wire_length, 1, 1, :right},


        {0, 1} => {:wire_bend,   2, 1},
        {1, 1} => {:wire_bend,   2, 2},


        {1, 0} => {:intersection, [
                  {:wire_length, 2, 3, :down},
                  {:wire_length, 1, 1, :right}
          ]
        }
      },
      wires_count: 2,
      intersections: %{
        {1, 0} => [
          {:wire_length, 2, 3, :down},
          {:wire_length, 1, 1, :right}
        ]
      }
    }

    actual_panel =
      new_front_panel()
      |> add_wire(wire1)
      |> add_wire(wire2)

    assert actual_panel == expected_panel
  end



  test_with_params "parse raw wires",
    fn raw_wire, expected_wire ->
      assert parse_raw_wire(raw_wire) == expected_wire
    end do
      [
        {"R8,U5,L5,D3",   [{:right, 8}, {:up, 5}, {:left, 5}, {:down, 3}]},
        {"R8,U5,L5,D3\n", [{:right, 8}, {:up, 5}, {:left, 5}, {:down, 3}]}
      ]
  end


  test_with_params "draw front panels",
    fn raw_wires, expected_drawing ->
      panel = new_front_panel(raw_wires)
      assert draw_front_panel(panel) == expected_drawing
    end do
      [
        {
          [
            "R4,U2,L2,D3"
          ],
          [
            ".......",
            "...+-+.",
            "...|.|.",
            ".o-|-+.",
            "...|...",
            "......."
          ]
        },
        {
          [
            "R8,U5,L5,D3"
          ],
          [
            "...........",
            "....+----+.",
            "....|....|.",
            "....|....|.",
            "....|....|.",
            ".........|.",
            ".o-------+.",
            "..........."
          ]
        },
        {
          [
            "R8,U5,L5,D3",
            "U7,R6,D4,L4"
          ],
          [
            "...........",
            ".+-----+...",
            ".|.....|...",
            ".|..+--X-+.",
            ".|..|..|.|.",
            ".|.-X--+.|.",
            ".|..|....|.",
            ".|.......|.",
            ".o-------+.",
            "..........."
          ]
        }
      ]
  end


  test_with_params "find intersection closest to central port",
    fn raw_wires, expected_intersection_and_distance ->
      panel = new_front_panel(raw_wires)
      {intersection, distance} = intersection_closest_to_central_port(panel)
      assert {intersection, distance} == expected_intersection_and_distance
    end do
      [
        {
          [
            "R8,U5,L5,D3",
            "U7,R6,D4,L4"
          ],
          {{3, 3}, 6}
        },
        {
          [
            "R75,D30,R83,U83,L12,D49,R71,U7,L72",
            "U62,R66,U55,R34,D71,R55,D58,R83"
          ],
          {{155, 4}, 159}
        },
        {
          [
            "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
            "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
          ],
          {{124, 11}, 135}
        }
      ]
  end



  test "update panel position with wire self-intersection" do
    initial_panel = %{
      items: %{
        {0, 0} => :central_port,


        {1, 0} => {:wire_length, 1,  1, :right},
        {2, 0} => {:wire_length, 1,  2, :right},
        {3, 0} => {:wire_length, 1,  3, :right},

        {4, 0} => {:wire_bend,   1,  4},

        {4, 1} => {:wire_length, 1,  5, :up},

        {4, 2} => {:wire_bend,   1,  6},

        {3, 2} => {:wire_length, 1,  7, :left},

        {2, 2} => {:wire_bend,   1,  8},

        {2, 1} => {:wire_length, 1,  9, :down}
      },
      wires_count: 1,
      intersections: %{}
    }

    position = {2, 0}
    item = {:wire_length, 1, 10, :down}

    expected_updated_panel = %{
      items: %{
        {0,  0} => :central_port,


        {1,  0} => {:wire_length, 1,  1, :right},
       #{2,  0} => {:wire_length, 1,  2, :right},
        {3,  0} => {:wire_length, 1,  3, :right},

        {4,  0} => {:wire_bend,   1,  4},

        {4,  1} => {:wire_length, 1,  5, :up},

        {4,  2} => {:wire_bend,   1,  6},

        {3,  2} => {:wire_length, 1,  7, :left},

        {2,  2} => {:wire_bend,   1,  8},

        {2,  1} => {:wire_length, 1,  9, :down},
       #{2,  0} => {:wire_length, 1, 10, :down},

        # Self-intersection:
        {2,  0} => [
                   {:wire_length, 1, 10, :down},
                   {:wire_length, 1,  2, :right}
        ]
      },
      wires_count: 1,
      intersections: %{}
    }

    actual_updated_panel = update_panel_position(initial_panel, position, item)
    assert actual_updated_panel == expected_updated_panel
  end


  test "update panel position with an existing wire bend" do
    initial_panel = %{
      items: %{
        {0, 0} => :central_port,

        {1, 0} => {:wire_bend, 1, 1},
        {1, 1} => {:wire_bend, 1, 2},
        {2, 1} => {:wire_bend, 1, 3},
        {2, 0} => {:wire_bend, 1, 4}
      },
      wires_count: 1,
      intersections: %{}
    }

    position = {1, 0}
    item = {:wire_length, 1, 5, :left}

    expected_updated_panel = %{
      items: %{
        {0, 0} => :central_port,

       #{1, 0} => {:wire_bend, 1, 1},
        {1, 1} => {:wire_bend, 1, 2},
        {2, 1} => {:wire_bend, 1, 3},
        {2, 0} => {:wire_bend, 1, 4},

        # Self-intersection:
        {1,  0} => [
                  item,
                  {:wire_bend, 1, 1}
        ]
      },
      wires_count: 1,
      intersections: %{}
    }

    actual_updated_panel = update_panel_position(initial_panel, position, item)
    assert actual_updated_panel == expected_updated_panel
  end


  test "update panel position with an existing list of wire items" do
    initial_panel = %{
      items: %{
        {0, 0} => :central_port,

       #{1, 0} => {:wire_bend, 1, 1},
        {1, 1} => {:wire_bend, 1, 2},
        {2, 1} => {:wire_bend, 1, 3},
        {2, 0} => {:wire_bend, 1, 4},
       #{1, 0} => {:wire_bend, 1, 5},

        # Self-intersection:
        {1,  0} => [
                  {:wire_bend, 1, 5},
                  {:wire_bend, 1, 1}
        ]
      },
      wires_count: 1,
      intersections: %{}
    }

    position = {1, 0}
    item = {:wire_length, 1, 6, :up}

    expected_updated_panel = %{
      items: %{
        {0, 0} => :central_port,

       #{1, 0} => {:wire_bend,   1, 1},
        {1, 1} => {:wire_bend,   1, 2},
        {2, 1} => {:wire_bend,   1, 3},
        {2, 0} => {:wire_bend,   1, 4},
       #{1, 0} => {:wire_bend,   1, 5},
       #{1, 0} => {:wire_length, 1, 6, :up},

        # Self-intersection:
        {1,  0} => [
                  {:wire_length, 1, 6, :up},
                  {:wire_bend,   1, 5},
                  {:wire_bend,   1, 1}
        ]
      },
      wires_count: 1,
      intersections: %{}
    }

    actual_updated_panel = update_panel_position(initial_panel, position, item)
    assert actual_updated_panel == expected_updated_panel
  end


  test "update panel position with an existing intersection" do
    initial_panel = %{
      items: %{
        {0,  0} => :central_port,

       #{1,  0} => {:wire_length, 1, 1, :right},

        {0,  1} => {:wire_bend,   2, 1},
        {1,  1} => {:wire_bend,   2, 2},
       #{1,  0} => {:wire_length, 2, 3, :down},
        {1, -1} => {:wire_bend,   2, 4},
        {2, -1} => {:wire_bend,   2, 5},
        {2,  0} => {:wire_bend,   2, 6},

        {1,  0} => {:intersection, [
                   {:wire_length, 2, 3, :down},
                   {:wire_length, 1, 1, :right}
          ]
        }
      },
      wires_count: 2,
      intersections: %{
        {1, 0} => [
          {:wire_length, 2, 3, :down},
          {:wire_length, 1, 1, :right}
        ]
      }
    }

    position = {1, 0}
    item = {:wire_length, 2, 7, :left}

    expected_updated_panel = %{
      items: %{
        {0,  0} => :central_port,

       #{1,  0} => {:wire_length, 1, 1, :right},

        {0,  1} => {:wire_bend,   2, 1},
        {1,  1} => {:wire_bend,   2, 2},
       #{1,  0} => {:wire_length, 2, 3, :down},
        {1, -1} => {:wire_bend,   2, 4},
        {2, -1} => {:wire_bend,   2, 5},
        {2,  0} => {:wire_bend,   2, 6},
       #{1,  0} => {:wire_length, 2, 7, :left}

        {1,  0} => {:intersection, [
                   item,
                   {:wire_length, 2, 3, :down},
                   {:wire_length, 1, 1, :right}
          ]
        }
      },
      wires_count: 2,
      intersections: %{
        {1, 0} => [
          item,
          {:wire_length, 2, 3, :down},
          {:wire_length, 1, 1, :right}
        ]
      }
    }

    actual_updated_panel = update_panel_position(initial_panel, position, item)
    assert actual_updated_panel == expected_updated_panel
  end


  test "update panel position with an intersecting item for an existing list of wire items" do
    initial_panel = %{
      items: %{
        {0,  0} => :central_port,

        {0,  1} => {:wire_bend,   1, 1},
        {1,  1} => {:wire_bend,   1, 2},
       #{1,  0} => {:wire_length, 1, 3, :down},
        {1, -1} => {:wire_bend,   1, 4},
        {2, -1} => {:wire_bend,   1, 5},
        {2,  0} => {:wire_bend,   1, 6},
       #{1,  0} => {:wire_length, 1, 7, :left}

        # Self-intersection:
        {1,  0} => [
                   {:wire_length, 1, 7, :left},
                   {:wire_length, 1, 3, :down}
        ]
      },
      wires_count: 1,
      intersections: %{}
    }

    position = {1, 0}
    item = {:wire_length, 2, 1, :right}

    expected_updated_panel = %{
      items: %{
        {0,  0} => :central_port,

        {0,  1} => {:wire_bend,   1, 1},
        {1,  1} => {:wire_bend,   1, 2},
       #{1,  0} => {:wire_length, 1, 3, :down},
        {1, -1} => {:wire_bend,   1, 4},
        {2, -1} => {:wire_bend,   1, 5},
        {2,  0} => {:wire_bend,   1, 6},
       #{1,  0} => {:wire_length, 1, 7, :left}

        {1,  0} => {:intersection, [
                   item,
                   {:wire_length, 1, 7, :left},
                   {:wire_length, 1, 3, :down}
          ]
        }
      },
      wires_count: 1, # `update_panel_position` doesn't update this.
      intersections: %{
        {1, 0} => [
          item,
          {:wire_length, 1, 7, :left},
          {:wire_length, 1, 3, :down}
        ]
      }
    }

    actual_updated_panel = update_panel_position(initial_panel, position, item)
    assert actual_updated_panel == expected_updated_panel
  end


  test "output answer" do
    assert output_answer() == 280
  end

end
