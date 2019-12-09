defmodule AdventOfCode2019.Day4Puzzle1Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  import AdventOfCode2019.Day4Puzzle1

  test_with_params "convert maybe-password to number",
    fn maybe_password, expected_number ->
      assert number_from_maybe_password(maybe_password) == expected_number
    end do
      [
        {         [1, 2, 3],    123},
        {[1, 2, 2, 3, 4, 5], 122345},
        {[1, 1, 1, 1, 2, 3], 111123},
        {[1, 3, 5, 6, 7, 9], 135679},
        {[1, 1, 1, 1, 1, 1], 111111},
        {[2, 2, 3, 4, 5, 0], 223450},
        {[1, 2, 3, 7, 8, 9], 123789}
      ]
  end

  test_with_params "two adjacent digits are the same?",
    fn maybe_password, expected_same? ->
      assert at_least_two_adjacent_digits_are_same?(maybe_password) == expected_same?
    end do
      [
        {[1, 2, 2, 3, 4, 5], true },
        {[1, 1, 1, 1, 2, 3], true },
        {[1, 3, 5, 6, 7, 9], false},
        {[1, 1, 1, 1, 1, 1], true },
        {[2, 2, 3, 4, 5, 0], true },
        {[1, 2, 3, 7, 8, 9], false}
      ]
  end

  test_with_params "digits never decrease?",
    fn maybe_password, expected ->
      assert digits_never_decrease?(maybe_password) == expected
    end do
      [
        {[1, 2, 2, 3, 4, 5], true },
        {[1, 1, 1, 1, 2, 3], true },
        {[1, 3, 5, 6, 7, 9], true },
        {[1, 1, 1, 1, 1, 1], true },
        {[2, 2, 3, 4, 5, 0], false},
        {[1, 2, 3, 7, 8, 9], true }
      ]
  end

end
