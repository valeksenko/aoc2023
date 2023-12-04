defmodule AoC2023.Day04.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/4
  """
  @behaviour AoC2023.Day

  import AoC2023.Day04.Parser

  @impl AoC2023.Day

  def run(data) do
    data
    |> Enum.map(&parse_card/1)
    |> Enum.map(&points/1)
    |> Enum.sum()
  end

  defp points({winnings, mine}) do
    matches = MapSet.intersection(MapSet.new(winnings), MapSet.new(mine))
    if Enum.empty?(matches), do: 0, else: Integer.pow(2, MapSet.size(matches) - 1)
  end
end
