defmodule AoC2023.Day15.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/15
  """
  @behaviour AoC2023.Day

  @impl AoC2023.Day

  def run(data) do
    data
    |> parse()
    |> Enum.map(&hash/1)
    |> Enum.sum()
  end

  defp hash(step) do
    step
    |> String.graphemes()
    |> Enum.reduce(0, &calculate/2)
  end

  defp calculate(char, current) do
    (17 * (current + (to_charlist(char) |> hd())))
    |> Integer.mod(256)
  end

  defp parse(data) do
    data
    |> hd()
    |> String.split(",")
  end
end
