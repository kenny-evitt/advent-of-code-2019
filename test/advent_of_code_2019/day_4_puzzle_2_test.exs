defmodule AdventOfCode2019.Day4Puzzle2Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  import AdventOfCode2019.Day4Puzzle2

  test_with_params "contains group of only two adjacent matching digits?",
    fn maybe_password, expected ->
      assert group_of_only_two_adjacent_matching_digits?(maybe_password) == expected
    end do
      [
        {[1, 2, 2, 3, 4, 5], true },
        {[1, 1, 1, 1, 2, 3], false},
        {[1, 3, 5, 6, 7, 9], false},
        {[1, 1, 1, 1, 1, 1], false},
        {[2, 2, 3, 4, 5, 0], true },
        {[1, 2, 3, 7, 8, 9], false},

        {[1, 1, 2, 2, 3, 3], true },
        {[1, 2, 3, 4, 4, 4], false},
        {[1, 1, 1, 1, 2, 2], true }
      ]
  end

end
