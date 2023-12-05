defmodule AoC2023.Day04.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/4#part2
  """
  @behaviour AoC2023.Day

  import AoC2023.Day04.Parser

  @impl AoC2023.Day

  def run(data) do
    data
    |> Enum.map(&parse_card/1)
    |> points()
  end

  defp points(cards) do
    match(
      Enum.map(cards, &elem(&1, 0)),
      0,
      cards |> Enum.reduce(Map.new(), fn {id, w, m}, c -> Map.put(c, id, {w, m}) end)
    )
  end

  defp match([], count, _), do: count

  defp match(cards, count, cardset) do
    cards
    |> Enum.reduce([], fn card, new -> new ++ play(card, cardset[card]) end)
    |> match(count + length(cards), cardset)
  end

  defp play(id, {winnings, mine}) do
    (id + 1)
    |> Stream.iterate(&(&1 + 1))
    |> Enum.take(
      MapSet.new(winnings)
      |> MapSet.intersection(MapSet.new(mine))
      |> MapSet.size()
    )
  end
end
