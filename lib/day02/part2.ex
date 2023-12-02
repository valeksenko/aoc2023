defmodule AoC2023.Day02.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/2#part2
  """
  @behaviour AoC2023.Day

  import AoC2023.Day02.Parser

  @impl AoC2023.Day

  def run(data) do
    data
    |> Enum.map(&parse_game/1)
    |> Enum.map(&game_power/1)
    |> Enum.sum()
  end

  defp game_power({_, picks}) do
    picks
    |> List.flatten()
    |> Enum.reduce(Map.new(), &map_min/2)
    |> Map.values()
    |> Enum.product()
  end

  defp map_min({amount, color}, mins),
    do: Map.put(mins, color, max(amount, Map.get(mins, color, 0)))
end
