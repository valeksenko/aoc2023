defmodule AoC2023.Day04.Parser do
  import NimbleParsec

  whitespaces = ascii_string([?\s], min: 1)

  numbers =
    times(
      ignore(whitespaces)
      |> integer(min: 1),
      min: 1
    )
    |> wrap()

  card =
    ignore(string("Card"))
    |> ignore(whitespaces)
    |> integer(min: 1)
    |> ignore(string(":"))
    |> repeat(numbers)
    |> ignore(string(" |"))
    |> repeat(numbers)

  # Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
  defparsec(:parse, card |> eos())

  def parse_card(data) do
    data
    |> parse()
    |> to_card()
  end

  defp to_card({:ok, [_id, winnings, mine], "", _, _, _}), do: {winnings, mine}
end
