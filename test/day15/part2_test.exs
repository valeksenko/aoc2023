defmodule AoC2023.Day15.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day15.Part2
  import AoC2023.Day15.Part2
  import TestHelper

  test "runs for sample input" do
    assert 145 == run(read_example(:day15))
  end
end
