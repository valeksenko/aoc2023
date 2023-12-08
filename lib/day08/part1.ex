defmodule AoC2023.Day08.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/8
  """
  @behaviour AoC2023.Day

  import AoC2023.Day08.Parser

  @impl AoC2023.Day

  @directions %{
    "L" => 0,
    "R" => 1
  }

  @first "AAA"
  @last "ZZZ"

  def run(data) do
    data
    |> parse_map()
    |> traverse()
  end

  defp traverse({directions, nodes}) do
    directions
    |> Stream.cycle()
    |> Stream.with_index()
    |> Enum.reduce_while({@first, nodes}, &step/2)
  end

  defp step({_, ind}, {@last, _}), do: {:halt, ind}

  defp step({dir, _}, {node, nodes}) do
    {:cont, {elem(nodes[node], @directions[dir]), nodes}}
  end
end
