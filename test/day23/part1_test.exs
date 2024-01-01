defmodule AoC2023.Day23.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day23.Part1
  import AoC2023.Day23.Part1
  import TestHelper

  test "runs for sample input" do
    assert 94 == run(read_example(:day23))
  end
end
