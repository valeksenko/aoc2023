defmodule AoC2023.Day11.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/11#part2
  """
  @behaviour AoC2023.Day

  @impl AoC2023.Day

  def run(data) do
    data
    |> parse()
    |> expand()
    |> permutations()
    |> Enum.map(&distance/1)
    |> Enum.sum()
  end

  defp expand({galaxies, max_x, max_y}) do
    galaxies
    |> expand_axis(0, max_x)
    |> expand_axis(1, max_y)
  end

  defp expand_axis(galaxies, axis, max_a) do
    empty = Enum.filter(0..max_a, &empty?(&1, axis, galaxies))

    galaxies
    |> Enum.reduce([], fn g, gs ->
      [put_elem(g, axis, elem(g, axis) + 999_999 * Enum.count(empty, &(&1 < elem(g, axis)))) | gs]
    end)
  end

  defp empty?(i, axis, galaxies), do: Enum.all?(galaxies, &(elem(&1, axis) != i))

  defp permutations(galaxies) do
    galaxies
    |> Enum.reduce(
      {[], []},
      fn galaxy, {pairs, processed} ->
        {pairs ++ Enum.zip_with([processed], &add_pair(&1, galaxy)), [galaxy | processed]}
      end
    )
    |> elem(0)
  end

  defp add_pair([g1], g2), do: {g1, g2}

  defp distance({{x1, y1}, {x2, y2}}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  defp parse(data) do
    {
      data |> Enum.with_index() |> Enum.reduce([], &add_row/2),
      String.length(data |> hd()) - 1,
      length(data) - 1
    }
  end

  defp add_row({row, y}, galaxies) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(galaxies, fn {v, x}, g -> if v == "#", do: [{x, y} | g], else: g end)
  end
end
