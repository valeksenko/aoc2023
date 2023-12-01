defmodule AoC2023.Day01.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/1
  """
  @behaviour AoC2023.Day

  @impl AoC2023.Day

  def run(data) do
    data
    |> Enum.map(&to_digits/1)
    |> Enum.map(&to_number/1)
    |> Enum.sum()
  end

  defp to_digits(input) do
    Regex.scan(~r{\d}, input)
    |> List.flatten()
  end

  defp to_number(digits) do
    (hd(digits) <> List.last(digits))
    |> String.to_integer()
  end
end
