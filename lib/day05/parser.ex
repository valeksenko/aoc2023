defmodule AoC2023.Day05.Parser do
  import NimbleParsec

  new_line = ascii_string([?\n], 1)
  whitespaces = ascii_string([?\s], min: 1)
  element = ascii_string([?a..?z], min: 1)

  range =
    times(
      ignore(optional(whitespaces))
      |> integer(min: 1),
      3
    )
    |> ignore(new_line)
    |> reduce({:to_ranges, []})

  map =
    element
    |> ignore(string("-to-"))
    |> concat(element)
    |> reduce({List, :to_tuple, []})
    |> ignore(string(" map:"))
    |> ignore(new_line)
    |> wrap(repeat(range))
    |> ignore(optional(new_line))
    |> reduce({List, :to_tuple, []})

  seeds =
    ignore(string("seeds:"))
    |> times(
      ignore(whitespaces)
      |> integer(min: 1),
      min: 1
    )
    |> ignore(new_line)
    |> wrap()

  almanac =
    seeds
    |> ignore(new_line)
    |> wrap(repeat(map))

  defparsec(:parse, almanac |> eos())

  def parse_almanac(data) do
    data
    |> parse()
    |> to_almanac()
  end

  defp to_almanac({:ok, [seeds, maps], "", _, _, _}), do: {seeds, maps}

  defp to_ranges([dst, src, amount]), do: {dst..(dst + amount - 1), src..(src + amount - 1)}
end
