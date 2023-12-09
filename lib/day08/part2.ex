defmodule AoC2023.Day08.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/8#part2
  """
  @behaviour AoC2023.Day

  import AoC2023.Day08.Parser

  @impl AoC2023.Day

  @directions %{
    "L" => 0,
    "R" => 1
  }

  @first "A"
  @last "Z"

  def run(data) do
    data
    |> parse_map()
    |> traverse()
  end

  defp traverse({directions, nodes}) do
    directions
    |> Stream.cycle()
    |> Stream.with_index()
    |> Enum.reduce_while(
      {nodes |> Map.keys() |> Enum.filter(&String.ends_with?(&1, @first)), nodes},
      &step/2
    )
  end

  defp step({dir, ind}, {current, nodes}) do
    if Enum.all?(current, &String.ends_with?(&1, @last)),
      do: {:halt, ind},
      else: {:cont, {Enum.map(current, &elem(nodes[&1], @directions[dir])), nodes}}
  end
end
