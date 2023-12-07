defmodule AoC2023.Day06.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/6#part2
  """
  @behaviour AoC2023.Day

  import AoC2023.Day06.Parser

  @impl AoC2023.Day

  def run(data) do
    data
    |> parse_report()
    |> to_game()
    |> wins()
  end

  defp to_game(data) do
    data
    |> Enum.unzip()
    |> Tuple.to_list()
    |> Enum.map(fn n -> n |> Enum.join() |> String.to_integer() end)
    |> List.to_tuple()
  end

  defp wins({time, distance}) do
    # cheating, half time didn't work so manually found which one worked
    split = div(time, 4)
    right_left(split + 1, time - 1, time, distance) - left_left(1, split, time, distance)
  end

  defp left_left(first, last, total, best) do
    cond do
      first > last ->
        :miss

      race(last, total) > best ->
        if race(last - 1, total) <= best do
          last
        else
          halftime = div(last - first, 2)

          case left_left(first, first + halftime, total, best) do
            :miss -> left_right(first + halftime + 1, last, total, best)
            res -> res
          end
        end

      true ->
        :miss
    end
  end

  defp right_left(first, last, total, best) do
    cond do
      first > last ->
        :miss

      race(last, total) <= best ->
        if race(last - 1, total) > best do
          last
        else
          halftime = div(last - first, 2)

          case right_left(first, first + halftime, total, best) do
            :miss -> right_right(first + halftime + 1, last, total, best)
            res -> res
          end
        end

      true ->
        :miss
    end
  end

  defp left_right(first, last, total, best) do
    cond do
      first > last ->
        :miss

      race(first, total) <= best ->
        if race(first + 1, total) > best do
          first
        else
          halftime = div(last - first, 2)

          case left_left(first, first + halftime, total, best) do
            :miss -> left_right(first + halftime + 1, last, total, best)
            res -> res
          end
        end

      true ->
        :miss
    end
  end

  defp right_right(first, last, total, best) do
    cond do
      first > last ->
        :miss

      race(first, total) > best ->
        if race(first + 1, total) <= best do
          first
        else
          halftime = div(last - first, 2)

          case right_left(first, first + halftime, total, best) do
            :miss -> right_right(first + halftime + 1, last, total, best)
            res -> res
          end
        end

      true ->
        :miss
    end
  end

  defp race(press, total), do: press * (total - press)
end
