defmodule AoC2023.Day09.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/9#part2
  """
  @behaviour AoC2023.Day

  @impl AoC2023.Day

  def run(data) do
    data
    |> Enum.map(&to_history/1)
    |> Enum.map(&prev_value/1)
    |> Enum.sum()
  end

  defp prev_value(values) do
    values
    |> Stream.iterate(&next_history/1)
    |> Stream.take_while(fn h -> !Enum.all?(h, &(&1 == 0)) end)
    |> Enum.to_list()
    |> Enum.reverse()
    |> Enum.reduce(0, &extrapolate/2)
  end

  defp extrapolate([value | _], increase), do: increase + value

  defp next_history(history) do
    history
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [v1, v2] -> v1 - v2 end)
  end

  defp to_history(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end
end
