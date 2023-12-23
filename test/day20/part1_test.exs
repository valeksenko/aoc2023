defmodule AoC2023.Day20.Part1Test do
  use ExUnit.Case
  doctest AoC2023.Day20.Part1
  import AoC2023.Day20.Part1
  import TestHelper

  test "runs for sample input" do
    assert 32_000_000 == run(read_example(:day20))
    assert 11_687_500 == run(read_example(:day20_1))
  end
end
