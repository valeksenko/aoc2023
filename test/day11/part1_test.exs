defmodule AoC2023.Day11.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day11.Part1
  import AoC2023.Day11.Part1
  import TestHelper

  test "runs for sample input" do
    assert 374 == run(read_example(:day11))
  end
end
