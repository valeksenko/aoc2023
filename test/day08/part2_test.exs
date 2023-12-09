defmodule AoC2023.Day08.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day08.Part2
  import AoC2023.Day08.Part2
  import TestHelper

  test "runs for sample input" do
    assert 6 == run(read_example_file(:day08_2))
  end
end
