defmodule AoC2023.Day07.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day07.Part2
  import AoC2023.Day07.Part2
  import TestHelper

  test "runs for sample input" do
    assert 5905 == run(read_example(:day07))
  end
end
