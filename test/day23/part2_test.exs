defmodule AoC2023.Day23.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day23.Part2
  import AoC2023.Day23.Part2
  import TestHelper

  test "runs for sample input" do
    assert 154 == run(read_example(:day23))
  end
end
