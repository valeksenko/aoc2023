defmodule AoC2023.Day05.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day05.Part1
  import AoC2023.Day05.Part1
  import TestHelper

  test "runs for sample input" do
    assert 35 == run(read_example_file(:Day05))
  end
end