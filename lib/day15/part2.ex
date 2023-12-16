defmodule AoC2023.Day15.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/15#part2
  """
  @behaviour AoC2023.Day

  @impl AoC2023.Day

  def run(data) do
    data
    |> parse()
    |> Enum.reduce(%{}, &hashmap/2)
    |> Enum.map(&focusing_power/1)
    |> Enum.sum()
  end

  defp hashmap([op, "-"], boxes) do
    boxes
    |> Map.get_and_update(
      hash(op),
      fn box ->
        {box, (box || []) |> Enum.reject(&(elem(&1, 0) == op))}
      end
    )
    |> elem(1)
  end

  defp hashmap([op, "=", fl], boxes) do
    boxes
    |> Map.get_and_update(
      hash(op),
      fn box ->
        {box, add_lens(box || [], op, fl)}
      end
    )
    |> elem(1)
  end

  defp add_lens(box, op, fl) do
    box
    |> Enum.reduce({[], :miss}, fn l, {b, r} ->
      if elem(l, 0) == op, do: {[{op, fl} | b], :found}, else: {[l | b], r}
    end)
    |> (fn {b, r} -> if r == :found, do: b, else: [{op, fl} | b] end).()
    |> Enum.reverse()
  end

  defp focusing_power({bi, box}) do
    box
    |> Enum.with_index(1)
    |> Enum.map(fn {{_, fl}, i} -> (bi + 1) * i * String.to_integer(fl) end)
    |> Enum.sum()
  end

  defp hash(op) do
    op
    |> String.graphemes()
    |> Enum.reduce(0, &calculate/2)
  end

  defp calculate(char, current) do
    (17 * (current + (to_charlist(char) |> hd())))
    |> Integer.mod(256)
  end

  defp parse(data) do
    data
    |> hd()
    |> String.split(",")
    |> Enum.map(&Regex.split(~r{[=-]}, &1, include_captures: true, trim: true))
  end
end
