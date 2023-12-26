defmodule AoC2023.Day25.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/25
  """
  @behaviour AoC2023.Day

  @impl AoC2023.Day

  def run(data) do
    data
    |> Enum.flat_map(&parse/1)
    |> disconnect()
    |> Enum.map(&MapSet.size/1)
    |> Enum.product()
  end

  defp parse(input) do
    [component, connected] = String.split(input, ": ")

    connected
    |> String.split(" ")
    |> Enum.map(&[component, &1])
  end

  defp disconnect(diagram) do
    diagram
    |> combinations(3)
    |> Enum.find(fn c -> length(connected(c, diagram)) == 2 end)
    |> connected(diagram)
  end

  defp connected(breaks, wires) do
    (wires -- breaks)
    |> connect([])
    |> Enum.map(fn w -> w |> List.flatten() |> MapSet.new() end)
    |> Enum.reduce([], &merge/2)
  end

  defp connect([], groups), do: groups

  defp connect([wire | wires], groups) do
    case Enum.find_index(groups, &connected?(&1, wire)) do
      nil -> connect(wires, [[wire] | groups])
      i -> connect(wires, groups |> List.update_at(i, &[wire | &1]))
    end
  end

  defp connected?(group, wire), do: Enum.any?(wire, fn c -> Enum.any?(group, &(c in &1)) end)

  defp merge(group, merged) do
    case Enum.reject(merged, &MapSet.disjoint?(&1, group)) do
      [] -> [group | merged]
      joint -> [Enum.reduce(joint, group, &MapSet.union/2) | merged -- joint]
    end
  end

  defp combinations(_, 0), do: [[]]
  defp combinations([], _), do: []

  defp combinations([h | t], k) do
    (for(l <- combinations(t, k - 1), do: [h | l]) ++ combinations(t, k))
    |> Enum.uniq()
  end
end
