defmodule AoC2023.Day21.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day21.Part2
  import AoC2023.Day21.Part2
  import TestHelper

  test "runs for sample input" do
    assert 6536 == run(read_example(:day21), 100)
  end
end
