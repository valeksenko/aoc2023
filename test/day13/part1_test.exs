defmodule AoC2023.Day13.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day13.Part1
  import AoC2023.Day13.Part1
  import TestHelper

  test "runs for sample input" do
    assert 405 == run(read_example(:day13, false))
  end
end
