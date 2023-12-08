defmodule AoC2023.Day08.Parser do
  import NimbleParsec

  new_line = ascii_string([?\n], 1)
  direction = ascii_string([?L, ?R], min: 1)
  node = ascii_string([?A..?Z], 3)

  entry =
    node
    |> ignore(string(" = ("))
    |> concat(node)
    |> ignore(string(", "))
    |> concat(node)
    |> ignore(string(")"))
    |> ignore(optional(new_line))
    |> wrap()

  map =
    repeat(direction)
    |> ignore(new_line)
    |> ignore(new_line)
    |> wrap(repeat(entry))

  defparsec(:parse, map |> eos())

  def parse_map(data) do
    data
    |> parse()
    |> to_map()
  end

  defp to_map({:ok, [directions, nodes], "", _, _, _}),
    do: {String.graphemes(directions), Enum.reduce(nodes, Map.new(), &add_node/2)}

  defp add_node([n1, n2, n3], nodes), do: Map.put(nodes, n1, {n2, n3})
end
