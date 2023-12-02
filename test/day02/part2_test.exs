defmodule AoC2023.Day02.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day02.Part2
  import AoC2023.Day02.Part2
  import TestHelper

  test "runs for sample input" do
    assert 2286 == run(read_example(:day02))
  end
end
