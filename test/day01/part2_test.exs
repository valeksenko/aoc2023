defmodule AoC2023.Day01.Part2Test do
  use ExUnit.Case
  doctest AoC2023.Day01.Part2
  import AoC2023.Day01.Part2
  import TestHelper

  test "runs for sample input" do
    assert 281 == run(read_example(:day01_2))
  end
end
