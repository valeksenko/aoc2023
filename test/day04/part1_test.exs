defmodule AoC2023.Day04.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day04.Part1
  import AoC2023.Day04.Part1
  import TestHelper

  test "runs for sample input" do
    assert 13 == run(read_example(:day04))
  end
end
