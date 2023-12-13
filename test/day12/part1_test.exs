defmodule AoC2023.Day12.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day12.Part1
  import AoC2023.Day12.Part1
  import TestHelper

  test "runs for sample input" do
    assert 21 == run(read_example(:day12))
  end
end
