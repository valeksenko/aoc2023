defmodule AoC2023.Day12.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/12
  """
  @behaviour AoC2023.Day

  import AoC2023.Day12.Parser

  @impl AoC2023.Day

  @operational "."
  @damaged "#"
  @unknown "?"

  def run(data) do
    data
    |> Enum.map(&parse_record/1)
    |> Enum.map(&arrangements/1)
    |> Enum.sum()
  end

  defp arrangements({conditions, groups}) do
    arrange(conditions, 0, groups)
  end

  defp arrange([], 0, []), do: 1
  defp arrange(_, current, []) when current > 0, do: 0

  defp arrange(conditions, 0, []),
    do: if(Enum.any?(conditions, &(&1 == @damaged)), do: 0, else: 1)

  defp arrange([], current, [group]) when current == group, do: 1
  defp arrange([], _, _), do: 0

  defp arrange([condition | conditions], current, [group | groups]) do
    cond do
      condition == @operational && current == group ->
        arrange(conditions, 0, groups)

      condition == @operational && current == 0 ->
        arrange(conditions, 0, [group | groups])

      condition == @operational ->
        0

      condition == @damaged && current == group ->
        0

      condition == @damaged ->
        arrange(conditions, current + 1, [group | groups])

      condition == @unknown && current == group ->
        arrange(conditions, 0, groups)

      condition == @unknown ->
        arrange([@operational | conditions], current, [group | groups]) +
          arrange([@damaged | conditions], current, [group | groups])
    end
  end
end
