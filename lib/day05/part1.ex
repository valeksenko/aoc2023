defmodule AoC2023.Day05.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/5
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

  defp lookup({seeds, maps}, target), do: Enum.map(seeds, &find(&1, "seed", target, maps))

  defp find(id, source, target, _) when source == target, do: id

  defp find(id, source, target, maps) do
    {{_, dst}, ranges} = Enum.find(maps, fn {{s, _}, _} -> s == source end)

    ranges
    |> Enum.find({id..id, id..id}, fn {_, s} -> id in s end)
    |> (fn {d, s} -> d.first + (id - s.first) end).()
    |> find(dst, target, maps)
  end
end
