defmodule AdventOfCode2019.IntcodeComputerProgramTest do
  use ExUnit.Case
  use ExUnit.Parameterized
  alias AdventOfCode2019.IntcodeComputerProgram

  test "values can be accessed beyond bounds of initial program" do
    initial_program = [99]
    program = IntcodeComputerProgram.new(initial_program)
    _ = IntcodeComputerProgram.at(program, 1)
    _ = IntcodeComputerProgram.at(program, 2)
    _ = IntcodeComputerProgram.at(program, 1000)
    assert true
  end

  test "values beyond the bounds of the initial program default to zero" do
    initial_program = [99]
    program = IntcodeComputerProgram.new(initial_program)
    assert IntcodeComputerProgram.at(program, 1)    == 0
    assert IntcodeComputerProgram.at(program, 2)    == 0
    assert IntcodeComputerProgram.at(program, 1000) == 0
  end

  test "accessing the value at a pointer with a negative value raises" do
    initial_program = [99]
    program = IntcodeComputerProgram.new(initial_program)
    assert_raise RuntimeError, fn -> IntcodeComputerProgram.at(program, -1) end
  end

  test "slice" do
    initial_program = [99]
    program = IntcodeComputerProgram.new(initial_program)
    assert IntcodeComputerProgram.slice(program, 13, 4) == [0, 0, 0, 0]
  end

  test "update at" do
    initial_program = [99]
    program = IntcodeComputerProgram.new(initial_program)
    pointer = 7
    new_value = 37
    new_program = IntcodeComputerProgram.update_at(program, 7, new_value)
    assert IntcodeComputerProgram.at(new_program, pointer) == new_value
  end

  test "program, with no updates, converted to list is initial program" do
    initial_program = [1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50]
    program = IntcodeComputerProgram.new(initial_program)
    assert IntcodeComputerProgram.to_list(program) == initial_program
  end


  test "program, with updates, converted to list is all values for valid pointers thru the max updated pointer" do
    initial_program = [99]

    program =
      IntcodeComputerProgram.new(initial_program)
      |> IntcodeComputerProgram.update_at(11, 12)
      |> IntcodeComputerProgram.update_at(19, 14)

    expected_list =
      [
        99,  0, 0, 0,  0,
         0,  0, 0, 0,  0,
         0, 12, 0, 0,  0,
         0,  0, 0, 0, 14
      ]

    assert IntcodeComputerProgram.to_list(program) == expected_list
  end


end
