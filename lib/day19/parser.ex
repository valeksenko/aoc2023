defmodule AoC2023.Day19.Parser do
  import NimbleParsec

  new_line = ascii_string([?\n], 1)
  workflow_name = ascii_string([?a..?z, ?A, ?R], min: 1)
  rate_name = ascii_string([?x, ?m, ?a, ?s], 1)
  cmp = ascii_string([?<, ?>], 1)

  part =
    ignore(string("{"))
    |> repeat(
      rate_name
      |> ignore(string("="))
      |> integer(min: 1)
      |> reduce({List, :to_tuple, []})
      |> ignore(optional(string(",")))
    )
    |> ignore(string("}"))
    |> wrap()
    |> ignore(optional(new_line))

  workflow =
    workflow_name
    |> ignore(string("{"))
    |> wrap(
      repeat(
        rate_name
        |> concat(cmp)
        |> integer(min: 1)
        |> ignore(string(":"))
        |> concat(workflow_name)
        |> reduce({List, :to_tuple, []})
        |> ignore(string(","))
      )
      |> concat(workflow_name)
    )
    |> ignore(string("}"))
    |> reduce({List, :to_tuple, []})
    |> ignore(new_line)

  system =
    repeat(workflow)
    |> wrap()
    |> ignore(new_line)
    |> wrap(repeat(part))

  # rfg{s<537:gd,x>2440:R,A}
  # {x=787,m=2655,a=1222,s=2876}
  defparsec(:parse, system |> eos())

  def parse_system(data) do
    data
    |> parse()
    |> to_system()
  end

  defp to_system({:ok, [workflows, parts], "", _, _, _}),
    do: {
      Map.new(workflows),
      Enum.map(parts, &Map.new/1)
    }
end
