defmodule AoC2023.Day08.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day08.Part1
  import AoC2023.Day08.Part1
  import TestHelper

  test "runs for sample input" do
    assert 2 == run(read_example_file(:day08))
    assert 6 == run(read_example_file(:day08_1))
  end
end
