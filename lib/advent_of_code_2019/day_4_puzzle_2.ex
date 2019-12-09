defmodule AdventOfCode2019.Day4Puzzle2 do
  import AdventOfCode2019.Day4Puzzle1,
    only: [digit?: 1, digits_never_decrease?: 1, maybe_password_from_number: 1]

  # Because `import` doesn't 'import' types:
  @type maybe_password :: AdventOfCode2019.Day4Puzzle1.maybe_password


  @spec group_of_only_two_adjacent_matching_digits?(maybe_password) :: boolean
  def group_of_only_two_adjacent_matching_digits?(maybe_password)

  def group_of_only_two_adjacent_matching_digits?([x, x, y, _, _, _]) when x != y,            do: true
  def group_of_only_two_adjacent_matching_digits?([y, x, x, z, _, _]) when x != y and x != z, do: true
  def group_of_only_two_adjacent_matching_digits?([_, y, x, x, z, _]) when x != y and x != z, do: true
  def group_of_only_two_adjacent_matching_digits?([_, _, y, x, x, z]) when x != y and x != z, do: true
  def group_of_only_two_adjacent_matching_digits?([_, _, _, y, x, x]) when x != y,            do: true
  def group_of_only_two_adjacent_matching_digits?(_), do: false


  @spec password_meets_criteria?(maybe_password) :: boolean
  def password_meets_criteria?(maybe_password) do
    Enum.all?(
      [
        length(maybe_password) == 6,
        Enum.map(maybe_password, &digit?/1) |> Enum.all?(),
        group_of_only_two_adjacent_matching_digits?(maybe_password),
        digits_never_decrease?(maybe_password)
      ]
    )
  end

  @spec process_input(%Range{}) :: [maybe_password]
  def process_input(first..last) do
    Enum.filter(
      first..last,
      fn maybe_password_number ->
        maybe_password_from_number(maybe_password_number)
        |> password_meets_criteria?()
      end
    )
  end

end
