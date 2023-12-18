defmodule AoC2023.Day17.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day17.Part1
  import AoC2023.Day17.Part1
  import TestHelper

  test "runs for sample input" do
    assert 102 == run(read_example(:day17))
  end
end
