defmodule AoC2023.Day16.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/16
  """
  @behaviour AoC2023.Day

  @empty "."

  @up {0, -1}
  @down {0, 1}
  @left {-1, 0}
  @right {1, 0}

  @impl AoC2023.Day

  def run(data) do
    data
    |> to_contraption()
    |> energized()
  end

  defp energized(schematic) do
    {[{{0, 0}, @right}], MapSet.new()}
    |> trace(schematic)
    # |> inspect_contraption()
    |> length()
  end

  defp trace({[], visited}, _),
    do: visited |> MapSet.to_list() |> Enum.map(&elem(&1, 0)) |> Enum.uniq()

  defp trace({beams, visited}, schematic) do
    beams
    |> Enum.reduce({[], visited}, fn {pos, dir}, s -> move(schematic[pos], pos, dir, s) end)
    |> trace(schematic)
  end

  defp move(element, pos, dir, state = {_, visited}) do
    cond do
      is_nil(element) -> state
      MapSet.member?(visited, {pos, dir}) -> state
      true -> match(element, pos, dir, state)
    end
  end

  defp match(element, pos, dir, {beams, visited}),
    do: {
      beams ++ Enum.map(directions(element, dir), &advance(pos, &1)),
      MapSet.put(visited, {pos, dir})
    }

  defp directions(@empty, dir), do: [dir]

  defp directions("-", @left), do: [@left]
  defp directions("-", @right), do: [@right]
  defp directions("-", @up), do: [@left, @right]
  defp directions("-", @down), do: [@left, @right]

  defp directions("|", @up), do: [@up]
  defp directions("|", @down), do: [@down]
  defp directions("|", @left), do: [@up, @down]
  defp directions("|", @right), do: [@up, @down]

  defp directions("\\", @left), do: [@up]
  defp directions("\\", @right), do: [@down]
  defp directions("\\", @up), do: [@left]
  defp directions("\\", @down), do: [@right]

  defp directions("/", @left), do: [@down]
  defp directions("/", @right), do: [@up]
  defp directions("/", @up), do: [@right]
  defp directions("/", @down), do: [@left]

  defp advance({x, y}, {dx, dy}), do: {{x + dx, y + dy}, {dx, dy}}

  defp to_contraption(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), &add_row/2)
  end

  defp add_row({row, y}, contraption) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(contraption, fn {v, x}, m -> Map.put(m, {x, y}, v) end)
  end

  # defp inspect_contraption(positions) do
  #   for y <- 0..(positions |> Enum.map(&elem(&1, 1)) |> Enum.max()) do
  #     for x <- 0..(positions |> Enum.map(&elem(&1, 0)) |> Enum.max()),
  #         do: IO.binwrite(if {x, y} in positions, do: "#", else: " ")

  #     IO.binwrite("\n")
  #   end

  #   IO.binwrite("\n\n")

  #   positions
  # end
end
