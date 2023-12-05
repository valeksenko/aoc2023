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
    cardset = Enum.reduce(cards, Map.new(), fn {id, w, m}, c -> Map.put(c, id, {w, m}) end)
    match(Map.from_keys(Map.keys(cardset), 1), 0, cardset)
  end

  defp match(cards, count, _) when cards == %{}, do: count

  defp match(cards, count, cardset) do
    cards
    |> Enum.reduce(Map.new(), fn card, new -> play(card, new, cardset) end)
    |> match(count + Enum.sum(Map.values(cards)), cardset)
  end

  defp play({id, amount}, cards, cardset) do
    (id + 1)..(id + map_size(cardset))
    |> Enum.take(point(cardset[id]))
    |> Enum.reduce(cards, fn i, c -> Map.update(c, i, amount, &(&1 + amount)) end)
  end

  defp point({winnings, mine}),
    do: MapSet.new(winnings) |> MapSet.intersection(MapSet.new(mine)) |> MapSet.size()
end
