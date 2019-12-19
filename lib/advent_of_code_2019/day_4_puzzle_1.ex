defmodule AdventOfCode2019.Day4Puzzle1 do

  @type maybe_digit :: pos_integer
  @type maybe_password :: [maybe_digit]

  @spec digit?(maybe_digit) :: boolean
  def digit?(maybe_digit), do: maybe_digit in 1..9


  @spec number_from_maybe_password(maybe_password) :: pos_integer
  def number_from_maybe_password(maybe_password) do
    {number, _} =
      Enum.reduce(
        Enum.reverse(maybe_password),
        {0, 1},
        fn maybe_digit, {number, multiplier} ->
          {
            number + (maybe_digit * multiplier),
            multiplier * 10
          }
        end
      )

    number
  end


  @spec at_least_two_adjacent_digits_are_same?(maybe_password) :: boolean
  def at_least_two_adjacent_digits_are_same?(maybe_password)

  def at_least_two_adjacent_digits_are_same?([x, x, _, _, _, _]), do: true
  def at_least_two_adjacent_digits_are_same?([_, x, x, _, _, _]), do: true
  def at_least_two_adjacent_digits_are_same?([_, _, x, x, _, _]), do: true
  def at_least_two_adjacent_digits_are_same?([_, _, _, x, x, _]), do: true
  def at_least_two_adjacent_digits_are_same?([_, _, _, _, x, x]), do: true
  def at_least_two_adjacent_digits_are_same?(_), do: false


  @spec digits_never_decrease?(maybe_password) :: boolean
  def digits_never_decrease?(maybe_password)

  def digits_never_decrease?([x, y, _, _, _, _]) when y < x, do: false
  def digits_never_decrease?([_, x, y, _, _, _]) when y < x, do: false
  def digits_never_decrease?([_, _, x, y, _, _]) when y < x, do: false
  def digits_never_decrease?([_, _, _, x, y, _]) when y < x, do: false
  def digits_never_decrease?([_, _, _, _, x, y]) when y < x, do: false
  def digits_never_decrease?(_), do: true


  @spec password_meets_criteria?(maybe_password) :: boolean
  def password_meets_criteria?(maybe_password)

  def password_meets_criteria?(maybe_password) when not is_list(maybe_password), do: false
  def password_meets_criteria?(maybe_password) when is_list(maybe_password) do
    Enum.all?(
      [
        length(maybe_password) == 6,
        Enum.map(maybe_password, &digit?/1) |> Enum.all?(),
        at_least_two_adjacent_digits_are_same?(maybe_password),
        digits_never_decrease?(maybe_password)
      ]
    )
  end


  @spec maybe_password_from_number(pos_integer) :: maybe_password
  def maybe_password_from_number(number) when number in 111111..999999 do
    Integer.digits(number)
  end

  def maybe_password_from_number(_), do: raise("Definitely not even a *maybe* password!")


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

  @spec output_answer(%Range{}) :: non_neg_integer
  def output_answer(first..last) do
    length(
      process_input(first..last)
    )
  end

end
