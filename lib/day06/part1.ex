defmodule AoC2023.Day06.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/6
  """
  @behaviour AoC2023.Day

  import AoC2023.Day06.Parser

  @impl AoC2023.Day

  def run(data) do
    data
    |> parse_report()
    |> Enum.map(&wins/1)
    |> Enum.product()
  end

  defp wins({time, distance}) do
    0..(time - 1)
    |> Enum.map(&race(&1, time))
    |> Enum.count(&(&1 > distance))
  end

  defp race(press, total), do: press * (total - press)
end
