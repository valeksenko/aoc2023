defmodule AoC2023.Day09.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day09.Part1
  import AoC2023.Day09.Part1
  import TestHelper

  test "runs for sample input" do
    assert 114 == run(read_example(:day09))
  end
end
