defmodule AoC2023.Day06.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day06.Part1
  import AoC2023.Day06.Part1
  import TestHelper

  test "runs for sample input" do
    assert 288 == run(read_example_file(:day06))
  end
end
