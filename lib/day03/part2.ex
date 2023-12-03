defmodule AoC2023.Day03.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/3#part2
  """
  @behaviour AoC2023.Day

  @gear "*"

  @impl AoC2023.Day

  def run(data) do
    data
    |> to_schematic()
    |> gear_ratios()
    |> Enum.sum()
  end

  defp gear_ratios(schematic) do
    schematic
    |> Enum.filter(fn {p, v} ->
      is_integer(v) && part?(schematic, p, length(Integer.digits(v)))
    end)
    |> Enum.map(fn {p, part} ->
      {part, neighbor_gears(schematic, p, length(Integer.digits(part)))}
    end)
    |> Enum.reduce(Map.new(), &to_gears/2)
    |> Map.values()
    |> Enum.filter(fn p -> length(p) == 2 end)
    |> Enum.map(&Enum.product/1)
  end

  defp neighbor_gears(schematic, {px, py}, width) do
    schematic
    |> Map.take(for(x <- (px - 1)..(px + width), y <- (py - 1)..(py + 1), do: {x, y}))
    |> Enum.filter(fn {_, v} -> v == @gear end)
    |> Enum.map(&elem(&1, 0))
  end

  defp to_gears({part, positions}, gears) do
    positions
    |> Enum.reduce(gears, fn p, g -> Map.update(g, p, [part], &[part | &1]) end)
  end

  defp to_schematic(data) do
    data
    |> Enum.with_index(1)
    |> Enum.reduce(Map.new(), &add_row/2)
  end

  defp add_row({row, y}, schematic) do
    (row <> ".")
    |> String.graphemes()
    |> Enum.with_index(1)
    |> Enum.reduce({schematic, ""}, &parse(&1, &2, y))
    |> elem(0)
  end

  defp part?(schematic, {px, py}, width) do
    for(x <- (px - 1)..(px + width), y <- (py - 1)..(py + 1), do: {x, y})
    |> Enum.any?(fn p -> !is_integer(Map.get(schematic, p, 0)) end)
  end

  defp parse({c, _}, {schematic, digits}, _) when c in ~w(0 1 2 3 4 5 6 7 8 9),
    do: {schematic, digits <> c}

  defp parse({c, x}, {schematic, ""}, y) do
    if c == ".",
      do: {schematic, ""},
      else: {Map.put(schematic, {x, y}, c), ""}
  end

  defp parse({c, x}, {schematic, digits}, y),
    do:
      parse(
        {c, x},
        {Map.put(schematic, {x - String.length(digits), y}, String.to_integer(digits)), ""},
        y
      )
end
