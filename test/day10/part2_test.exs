defmodule AoC2023.Day10.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day10.Part2
  import AoC2023.Day10.Part2
  import TestHelper

  test "runs for sample input" do
    assert 4 == run(read_example(:day10_2))
    assert 8 == run(read_example(:day10_3))
    assert 10 == run(read_example(:day10_4))
  end
end
