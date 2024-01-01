defmodule AoC2023.Day23.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/23
  """
  @behaviour AoC2023.Day

  @up {0, -1}
  @down {0, 1}
  @left {-1, 0}
  @right {1, 0}

  @directions %{
    "." => [@up, @down, @left, @right],
    "^" => [@up],
    "v" => [@down],
    "<" => [@left],
    ">" => [@right]
  }

  @impl AoC2023.Day

  def run(data) do
    data
    |> to_map()
    |> longest_hike()
    |> length()
    |> Kernel.-(2)
  end

  defp longest_hike(map) do
    start = map |> Map.keys() |> Enum.find(fn {_, y} -> y == 0 end)
    finish = map |> Map.keys() |> Enum.max_by(&elem(&1, 1))

    walks([], [start], start, finish, map)
    |> Enum.max_by(&length/1)
  end

  defp walks(paths, path, finish, finish, _), do: [[finish | path] | paths]

  defp walks(paths, path, position, finish, map) do
    @directions
    |> Map.get(map[position])
    |> Enum.map(&next(position, &1))
    |> Enum.filter(&Map.has_key?(map, &1))
    |> Enum.reject(&(&1 in path))
    |> walk(paths, [position | path], finish, map)
  end

  defp walk([], paths, _, _, _), do: paths

  defp walk(positions, paths, path, finish, map) do
    positions
    |> Enum.reduce(paths, fn pos, ps -> walks(ps, path, pos, finish, map) end)
  end

  defp next({x, y}, {dx, dy}), do: {x + dx, y + dy}

  defp to_map(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), &add_row/2)
  end

  defp add_row({row, y}, map) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(map, fn {v, x}, m -> if v == "#", do: m, else: Map.put(m, {x, y}, v) end)
  end
end
