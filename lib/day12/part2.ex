defmodule AoC2023.Day12.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/12#part2
  """
  @behaviour AoC2023.Day

  import AoC2023.Day12.Parser

  @impl AoC2023.Day

  @operational "."
  @damaged "#"
  @unknown "?"

  @multiplier 5

  def run(data) do
    data
    |> Enum.map(&parse_record/1)
    |> Enum.map(&arrangements/1)
    |> Enum.sum()
  end

  defp arrangements({conditions, groups}) do
    arrange(
      conditions
      |> Enum.concat([@unknown])
      |> Stream.cycle()
      |> Enum.take(@multiplier - 1 + @multiplier * length(conditions)),
      0,
      groups |> Stream.cycle() |> Enum.take(@multiplier * length(groups)),
      %{}
    )
    |> elem(0)
  end

  defp arrange([], 0, [], cache), do: {1, cache}

  defp arrange(_, current, [], cache) when current > 0, do: {0, cache}

  defp arrange(conditions, 0, [], cache),
    do: {if(Enum.any?(conditions, &(&1 == @damaged)), do: 0, else: 1), cache}

  defp arrange([], current, [group], cache) when current == group, do: {1, cache}

  defp arrange([], _, _, cache), do: {0, cache}

  defp arrange([condition | conditions], current, [group | groups], cache) do
    cache_key = {[condition | conditions], current, [group | groups]}

    cond do
      cache[cache_key] ->
        {cache[cache_key], cache}

      condition == @operational && current == group ->
        arrange(conditions, 0, groups, cache) |> update_cache(cache_key)

      condition == @operational && current == 0 ->
        arrange(conditions, 0, [group | groups], cache) |> update_cache(cache_key)

      condition == @operational ->
        {0, Map.put(cache, cache_key, 0)}

      condition == @damaged && current == group ->
        {0, Map.put(cache, cache_key, 0)}

      condition == @damaged ->
        arrange(conditions, current + 1, [group | groups], cache) |> update_cache(cache_key)

      condition == @unknown && current == group ->
        arrange(conditions, 0, groups, cache) |> update_cache(cache_key)

      condition == @unknown ->
        arrange([@operational | conditions], current, [group | groups], cache)
        |> (fn {v, c} -> {v, arrange([@damaged | conditions], current, [group | groups], c)} end).()
        |> add_cache(cache_key)
    end
  end

  defp update_cache({v, cache}, cache_key), do: {v, cache |> Map.put(cache_key, v)}

  defp add_cache({v1, {v2, cache}}, cache_key), do: update_cache({v1 + v2, cache}, cache_key)
end
