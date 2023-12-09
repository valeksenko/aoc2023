defmodule AoC2023.Day09.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day09.Part2
  import AoC2023.Day09.Part2
  import TestHelper

  test "runs for sample input" do
    assert 2 == run(read_example(:day09))
  end
end
