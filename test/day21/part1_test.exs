defmodule AoC2023.Day21.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day21.Part1
  import AoC2023.Day21.Part1
  import TestHelper

  test "runs for sample input" do
    assert 16 == run(read_example(:day21), 6)
  end
end
