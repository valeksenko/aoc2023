defmodule AoC2023.Day25.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/25
  """
  @behaviour AoC2023.Day

  @impl AoC2023.Day

  def run(data) do
    data
    |> Enum.reduce(%{}, &parse/2)
    |> disconnect()
    |> Enum.map(&length/1)
    |> Enum.product()
  end

  defp parse(input, diagram) do
    [component, constr] = String.split(input, ": ")
    components = String.split(constr, " ")

    components
    |> Enum.reduce(
      Map.update(diagram, component, components, &(&1 ++ components)),
      fn c, d -> Map.update(d, c, [component], &[component | &1]) end
    )
  end

  defp disconnect(diagram) do
    diagram
    |> Enum.flat_map(fn {c, cc} -> Enum.map(cc, &[c, &1]) end)
    |> combinations(3)
    |> Enum.find(&(length(connected(&1, diagram)) == 2))
    |> connected(diagram)
  end

  defp connected(breaks, diagram) do
    breaks
    |> Enum.reduce(diagram, fn [c1, c2], d ->
      d |> Map.update!(c1, &List.delete(&1, c2)) |> Map.update!(c2, &List.delete(&1, c1))
    end)
    |> connect([])
  end

  defp connect(diagram, groups) when diagram == %{}, do: groups

  # optimization: stop earlier
  defp connect(_, groups) when length(groups) == 2, do: [[] | groups]

  defp connect(diagram, groups) do
    {group, leftover} = group_connections(diagram |> Map.keys() |> hd(), {[], diagram})

    connect(leftover, [group | groups])
  end

  defp group_connections(component, {group, diagram}) do
    case Map.pop(diagram, component) do
      {nil, leftover} ->
        {group, leftover}

      {components, leftover} ->
        Enum.reduce(components, {[component | group], leftover}, &group_connections/2)
    end
  end

  defp combinations(_, 0), do: [[]]
  defp combinations([], _), do: []

  defp combinations([h | t], k) do
    (for(l <- combinations(t, k - 1), do: [h | l]) ++ combinations(t, k))
    |> Enum.uniq()
  end
end
