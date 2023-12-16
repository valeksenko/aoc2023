defmodule AoC2023.Day16.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day16.Part1
  import AoC2023.Day16.Part1
  import TestHelper

  test "runs for sample input" do
    assert 46 == run(read_example(:day16))
  end
end
