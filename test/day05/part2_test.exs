defmodule AoC2023.Day05.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day05.Part2
  import AoC2023.Day05.Part2
  import TestHelper

  test "runs for sample input" do
    assert 46 == run(read_example_file(:day05))
  end
end
