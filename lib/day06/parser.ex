defmodule AoC2023.Day06.Parser do
  import NimbleParsec

  new_line = ascii_string([?\n], 1)
  whitespaces = ascii_string([?\s], min: 1)

  data =
    times(
      ignore(whitespaces)
      |> integer(min: 1),
      min: 1
    )
    |> wrap()

  report =
    ignore(string("Time:"))
    |> concat(data)
    |> ignore(new_line)
    |> ignore(string("Distance:"))
    |> concat(data)
    |> ignore(optional(new_line))

  defparsec(:parse, report |> eos())

  def parse_report(data) do
    data
    |> parse()
    |> to_report()
  end

  defp to_report({:ok, [times, distances], "", _, _, _}), do: Enum.zip(times, distances)
end
