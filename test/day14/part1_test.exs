defmodule AoC2023.Day14.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day14.Part1
  import AoC2023.Day14.Part1
  import TestHelper

  test "runs for sample input" do
    assert 136 == run(read_example(:day14))
  end
end
