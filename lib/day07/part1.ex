defmodule AoC2023.Day07.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/7
  """
  @behaviour AoC2023.Day

  @card_order ~w(2 3 4 5 6 7 8 9 T J Q K A)

  @hand_order [
    # Five of a kind
    [5],
    # Four of a kind
    [4],
    # Full house
    [3, 2],
    # Three of a kind
    [3],
    # Two pair
    [2, 2],
    # One pair
    [2],
    # High card
    [1]
  ]
  @impl AoC2023.Day

  def run(data) do
    data
    |> Enum.map(&parse/1)
    |> Enum.map(&with_frequencies/1)
    |> Enum.sort(&rank/2)
    |> Enum.with_index(1)
    |> Enum.map(&score/1)
    |> Enum.sum()
  end

  defp parse(input) do
    [hand, bid] = String.split(input)
    {String.graphemes(hand), String.to_integer(bid)}
  end

  defp rank({h1, _, f1}, {h2, _, f2}) do
    cond do
      hand_rank(f1) == hand_rank(f2) ->
        Enum.zip(h1, h2)
        |> Enum.find(fn {c1, c2} -> card_rank(c1) != card_rank(c2) end)
        |> (fn {c1, c2} -> card_rank(c1) < card_rank(c2) end).()

      true ->
        hand_rank(f1) < hand_rank(f2)
    end
  end

  defp hand_rank(freqs),
    do:
      length(@hand_order) - Enum.find_index(@hand_order, fn h -> List.starts_with?(freqs, h) end)

  defp card_rank(card), do: Enum.find_index(@card_order, &(&1 == card))

  defp with_frequencies({hand, bid}),
    do: {hand, bid, hand |> Enum.frequencies() |> Map.values() |> Enum.sort(:desc)}

  defp score({{_, bid, _}, ind}), do: ind * bid
end
