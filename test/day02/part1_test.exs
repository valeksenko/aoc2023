defmodule AoC2023.Day02.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day02.Part1
  import AoC2023.Day02.Part1
  import TestHelper

  test "runs for sample input" do
    assert 8 == run(read_example(:day02))
  end
end
