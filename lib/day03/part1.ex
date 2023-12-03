defmodule AoC2023.Day03.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/3
  """
  @behaviour AoC2023.Day

  @impl AoC2023.Day

  def run(data) do
    data
    |> to_schematic()
    |> detect_parts()
    |> Enum.sum()
  end

  defp detect_parts(schematic) do
    schematic
    |> Enum.filter(fn {p, v} ->
      is_integer(v) && part?(schematic, p, length(Integer.digits(v)))
    end)
    |> Enum.map(&elem(&1, 1))
  end

  defp part?(schematic, {px, py}, width) do
    for(x <- (px - 1)..(px + width), y <- (py - 1)..(py + 1), do: {x, y})
    |> Enum.any?(fn p -> !is_integer(Map.get(schematic, p, 0)) end)
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
