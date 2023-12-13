defmodule AoC2023.Day12.Parser do
  import NimbleParsec

  numbers =
    times(
      ignore(optional(string(",")))
      |> integer(min: 1),
      min: 1
    )
    |> wrap()

  record =
    ascii_string([?., ??, ?#], min: 1)
    |> ignore(string(" "))
    |> repeat(numbers)

  # .??..??...?##. 1,1,3
  defparsec(:parse, record |> eos())

  def parse_record(data) do
    data
    |> parse()
    |> to_record()
  end

  defp to_record({:ok, [conditions, groups], "", _, _, _}),
    do: {String.graphemes(conditions), groups}
end
