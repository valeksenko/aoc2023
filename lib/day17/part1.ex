defmodule AoC2023.Day17.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/17
  """
  @behaviour AoC2023.Day

  @up {0, -1}
  @down {0, 1}
  @left {-1, 0}
  @right {1, 0}

  @directions %{
    :start => [@right, @down],
    @up => [@left, @right, @up],
    @down => [@left, @right, @down],
    @left => [@left, @up, @down],
    @right => [@right, @up, @down]
  }

  @impl AoC2023.Day

  def run(data) do
    data
    |> to_map()
    |> min_heat_loss()
  end

  defp min_heat_loss(map) do
    max_x = map |> Map.keys() |> Enum.map(&elem(&1, 0)) |> Enum.max()
    max_y = map |> Map.keys() |> Enum.map(&elem(&1, 1)) |> Enum.max()

    finish = fn {{pos, _}, _} -> pos == {max_x, max_y} end
    cost = fn _, {{pos, _}, _} -> map[pos] end
    # we can't estimate, so using it as a Dijkstra's
    estimated_cost = fn _, _ -> 1 end

    next = fn {{pos, dir}, dirs} ->
      @directions[dir] |> Enum.map(fn d -> {move(pos, d), [d | dirs]} end) |> prune(max_x, max_y)
    end

    Astar.astar({next, cost, estimated_cost}, {{{0, 0}, :start}, []}, finish)
    |> Enum.map(fn {{pos, _}, _} -> map[pos] end)
    |> Enum.sum()
  end

  defp move({x, y}, {dx, dy}), do: {{x + dx, y + dy}, {dx, dy}}

  defp prune(next, max_x, max_y) do
    next
    |> Enum.filter(fn {{{x, y}, _}, _} -> x in 0..max_x && y in 0..max_y end)
    |> Enum.reject(fn {_, dirs} ->
      dirs |> Enum.take(4) |> Enum.frequencies() |> (fn d -> Map.values(d) == [4] end).()
    end)
  end

  defp to_map(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), &add_row/2)
  end

  defp add_row({row, y}, map) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(map, fn {v, x}, m -> Map.put(m, {x, y}, String.to_integer(v)) end)
  end
end
