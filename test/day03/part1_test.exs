defmodule AoC2023.Day03.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day03.Part1
  import AoC2023.Day03.Part1
  import TestHelper

  test "runs for sample input" do
    assert 4361 == run(read_example(:day03))
  end
end
