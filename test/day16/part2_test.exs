defmodule AoC2023.Day16.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day16.Part2
  import AoC2023.Day16.Part2
  import TestHelper

  test "runs for sample input" do
    assert 51 == run(read_example(:day16))
  end
end
