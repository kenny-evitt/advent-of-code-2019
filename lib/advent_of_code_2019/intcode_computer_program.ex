defmodule AdventOfCode2019.IntcodeComputerProgram do

  @type value :: AdventOfCode2019.Day2Puzzle1.value

  @type initial_program :: [value]
  @type t               :: %{required(non_neg_integer) => value}

  @spec new(initial_program) :: t
  def new(initial_program) do
    initial_program
    |> Enum.with_index()
    |> Map.new(fn {value, index} -> {index, value} end)
  end

  @type pointer :: AdventOfCode2019.Day2Puzzle1.pointer


  @spec at(t, pointer) :: value
  def at(program, pointer)

  def at(program, pointer) when is_integer(pointer) and pointer >= 0 do
    if Map.has_key?(program, pointer) do
      program[pointer]
    else
      0
    end
  end

  def at(_program, pointer) when is_integer(pointer) and pointer < 0 do
    raise("It is invalid to try to access memory at a negative address.")
  end


  @spec slice(t, pointer, non_neg_integer) :: [value]
  def slice(program, pointer, count)

  def slice(_program, pointer, 0)
  when is_integer(pointer) and pointer >= 0, do: []

  def slice(program, pointer, count) when is_integer(pointer) and pointer >= 0 and count > 0 do
    Enum.map(
      pointer..(pointer + count - 1),
      fn pointer -> at(program, pointer) end
    )
  end


  @spec update_at(t, pointer, value) :: t
  def update_at(program, pointer, value) when is_integer(pointer) and pointer >= 0 do
    Map.put(program, pointer, value)
  end


  @spec to_list(t) :: [value]
  def to_list(program) do
    max_pointer =
      Enum.max(
        Map.keys(program)
      )

    Enum.map(
      0..max_pointer,
      fn pointer -> at(program, pointer) end
    )
  end


end
