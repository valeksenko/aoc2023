defmodule AoC2023.Day12.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day12.Part2
  import AoC2023.Day12.Part2
  import TestHelper

  test "runs for sample input" do
    assert 525_152 == run(read_example(:day12))
  end
end
