defmodule AoC2023.Day14.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/14
  """
  @behaviour AoC2023.Day

  @round "O"
  @cube "#"

  @impl AoC2023.Day

  def run(data) do
    data
    |> to_dish()
    |> tilt()
    |> Enum.sum()
  end

  defp tilt({dish, max_x, max_y}) do
    0..max_x
    |> Enum.reduce([], fn x, l -> tilt_column(x, dish, max_y) |> elem(0) |> Enum.concat(l) end)
  end

  defp tilt_column(on_x, dish, max_y) do
    dish
    |> Enum.filter(fn {{x, _}, _} -> x == on_x end)
    |> Enum.sort_by(fn {{_, y}, _} -> y end)
    |> Enum.reduce({[], 0}, &calculate_load(&1, &2, max_y))
  end

  defp calculate_load({_, @round}, {loads, start_y}, max_y),
    do: {[max_y - start_y + 1 | loads], start_y + 1}

  defp calculate_load({{_, y}, @cube}, {loads, _}, _), do: {loads, y + 1}

  defp to_dish(data) do
    {
      data |> Enum.with_index() |> Enum.reduce(Map.new(), &add_row/2),
      String.length(data |> hd()) - 1,
      length(data) - 1
    }
  end

  defp add_row({row, y}, dish) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(dish, fn {v, x}, d -> if v == ".", do: d, else: Map.put(d, {x, y}, v) end)
  end
end
