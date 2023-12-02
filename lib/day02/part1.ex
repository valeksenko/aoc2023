defmodule AoC2023.Day02.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/2
  """
  @behaviour AoC2023.Day

  import AoC2023.Day02.Parser

  @limits %{
    "red" => 12,
    "green" => 13,
    "blue" => 14
  }

  @impl AoC2023.Day

  def run(data) do
    data
    |> Enum.map(&parse_game/1)
    |> Enum.filter(&valid_game?/1)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  defp valid_game?({_, picks}), do: Enum.all?(picks, &valid_round?/1)

  defp valid_round?(picks), do: Enum.all?(picks, &valid_die?/1)

  defp valid_die?({amount, color}), do: amount <= Map.get(@limits, color)
end
