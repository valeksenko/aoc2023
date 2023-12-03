defmodule AoC2023.Day03.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day03.Part2
  import AoC2023.Day03.Part2
  import TestHelper

  test "runs for sample input" do
    assert 467_835 == run(read_example(:day03))
  end
end
