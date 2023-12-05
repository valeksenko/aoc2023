defmodule AoC2023.Day05.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/5#part2
  """
  @behaviour AoC2023.Day

  import AoC2023.Day05.Parser

  @impl AoC2023.Day

  def run(data) do
    data
    |> parse_almanac()
    |> lookup("location")
    |> Enum.min()
  end

  defp lookup({seeds, maps}, target), do: Enum.map(all(seeds), &find(&1, "seed", target, maps))

  defp find(id, source, target, _) when source == target, do: id

  defp find(id, source, target, maps) do
    {{_, dst}, ranges} = Enum.find(maps, fn {{s, _}, _} -> s == source end)

    ranges
    |> Enum.find({id..id, id..id}, fn {_, s} -> id in s end)
    |> (fn {d, s} -> d.first + (id - s.first) end).()
    |> find(dst, target, maps)
  end

  defp all(seeds) do
    seeds
    |> Enum.chunk_every(2)
    |> Enum.flat_map(fn [s, a] -> Enum.to_list(s..(s + a - 1)) end)
  end
end
