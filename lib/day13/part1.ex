defmodule AoC2023.Day13.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/13
  """
  @behaviour AoC2023.Day

  @impl AoC2023.Day

  def run(data) do
    data
    |> parse()
    |> Enum.map(&score/1)
    |> Enum.sum()
  end

  defp score(pattern) do
    case find_mirror(pattern) do
      0 -> transpose(pattern) |> find_mirror()
      n -> 100 * n
    end
  end

  defp find_mirror(pattern) do
    1..(length(pattern) - 1)
    |> Enum.find(0, &mirror?(pattern, &1))
  end

  defp mirror?(pattern, i) do
    pattern
    |> Enum.split(i)
    |> reflection?()
  end

  defp reflection?({first, second}) do
    amount = min(length(first), length(second))
    Enum.reverse(first) |> Enum.take(amount) == Enum.take(second, amount)
  end

  defp parse(data) do
    data
    |> Enum.map(&String.graphemes/1)
    |> Enum.chunk_by(&Enum.empty?/1)
    |> Enum.reject(&(&1 == [[]]))
  end

  defp transpose(list), do: Enum.zip_with(list, &Function.identity/1)
end
