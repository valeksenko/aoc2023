defmodule AoC2023.Day24.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day24.Part1
  import AoC2023.Day24.Part1
  import TestHelper

  test "runs for sample input" do
    assert 2 == run(read_example(:day24), {7, 27})
  end
end
