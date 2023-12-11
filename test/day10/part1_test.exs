defmodule AoC2023.Day10.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day10.Part1
  import AoC2023.Day10.Part1
  import TestHelper

  test "runs for sample input" do
    assert 4 == run(read_example(:day10))
    assert 8 == run(read_example(:day10_1))
  end
end
