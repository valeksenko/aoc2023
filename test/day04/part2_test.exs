defmodule AoC2023.Day04.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day04.Part2
  import AoC2023.Day04.Part2
  import TestHelper

  test "runs for sample input" do
    assert 30 == run(read_example(:day04))
  end
end
