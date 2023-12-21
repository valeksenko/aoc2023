defmodule AoC2023.Day21.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/21#part2
  """
  @behaviour AoC2023.Day

  @impl AoC2023.Day

  @north {0, -1}
  @south {0, 1}
  @east {1, 0}
  @west {-1, 0}

  @directions [@north, @south, @east, @west]

  def run(data, steps \\ 26_501_365) do
    data
    |> parse()
    |> walk(steps)
  end

  defp walk({garden, start}, steps) do
    max_x = garden |> Enum.map(&elem(&1, 0)) |> Enum.max()
    max_y = garden |> Enum.map(&elem(&1, 1)) |> Enum.max()

    1..steps
    |> Enum.reduce(start, fn _, p -> move(p, garden, max_x + 1, max_y + 1) end)
    |> MapSet.size()
  end

  defp move(positions, garden, mod_x, mod_y) do
    positions
    |> Enum.reduce(MapSet.new(), &step(&1, &2, garden, mod_x, mod_y))
  end

  defp step({x, y}, positions, garden, mod_x, mod_y) do
    @directions
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
    |> Enum.reduce(positions, fn p, ps ->
      if MapSet.member?(garden, position(p, mod_x, mod_y)), do: MapSet.put(ps, p), else: ps
    end)
  end

  defp position({x, y}, mod_x, mod_y), do: {Integer.mod(x, mod_x), Integer.mod(y, mod_y)}

  defp parse(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce({MapSet.new(), MapSet.new()}, &add_row/2)
  end

  defp add_row({row, y}, state) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(state, fn {v, x}, s -> add(s, {x, y}, v) end)
  end

  defp add({garden, start}, pos, value) do
    case value do
      "#" -> {garden, start}
      "." -> {MapSet.put(garden, pos), start}
      "S" -> {MapSet.put(garden, pos), MapSet.put(start, pos)}
    end
  end
end
