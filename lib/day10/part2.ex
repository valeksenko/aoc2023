defmodule AoC2023.Day10.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/10#part2
  """
  @behaviour AoC2023.Day

  @north {0, -1}
  @south {0, 1}
  @east {1, 0}
  @west {-1, 0}

  @directions [@north, @south, @east, @west]

  @connections %{
    @north => @south,
    @south => @north,
    @east => @west,
    @west => @east
  }

  @impl AoC2023.Day

  def run(data) do
    data
    |> parse()
    |> farthest()
  end

  defp farthest(map) do
    start(map)
    |> Enum.reduce_while([], &next_pipe(&1, &2, map))
    |> length()
    |> Kernel./(2)
    |> ceil()
  end

  defp start(map) do
    case Enum.find(map, fn {_, v} -> v == :start end) do
      {pos, _} -> Enum.map(@directions, fn dir -> {pos, dir} end)
    end
  end

  def next_pipe({pos = {x, y}, dir = {dx, dy}}, collected, map) do
    next = {x + dx, y + dy}

    case map[next] do
      nil ->
        {:cont, []}

      :ground ->
        {:cont, []}

      :start ->
        {:halt, [{pos, :start} | collected]}

      {dir1, dir2} ->
        cond do
          dir == @connections[dir1] -> next_pipe({next, dir2}, [{pos, dir} | collected], map)
          dir == @connections[dir2] -> next_pipe({next, dir1}, [{pos, dir} | collected], map)
          true -> {:cont, []}
        end
    end
  end

  defp parse(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce(%{}, &add_row/2)
  end

  defp add_row({row, y}, map) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(map, &add_direction(&1, &2, y))
  end

  defp add_direction({sym, x}, map, y) do
    case to_direction(sym) do
      :ground -> map
      dir -> Map.put(map, {x, y}, dir)
    end
  end

  defp to_direction("|"), do: {@north, @south}
  defp to_direction("-"), do: {@east, @west}
  defp to_direction("L"), do: {@north, @east}
  defp to_direction("J"), do: {@north, @west}
  defp to_direction("7"), do: {@south, @west}
  defp to_direction("F"), do: {@south, @east}
  defp to_direction("S"), do: :start
  defp to_direction("."), do: :ground
end
