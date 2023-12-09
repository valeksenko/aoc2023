defmodule AoC2023.Day06.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day06.Part2
  import AoC2023.Day06.Part2
  import TestHelper

  test "runs for sample input" do
    assert 71503 == run(read_example_file(:day06), 2)
  end
end
