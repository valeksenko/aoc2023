defmodule AoC2023.Day02.Parser do
  import NimbleParsec

  color = ascii_string([?a..?z], min: 1)

  pick =
    integer(min: 1)
    |> ignore(string(" "))
    |> concat(color)
    |> reduce({List, :to_tuple, []})

  round =
    times(
      pick
      |> ignore(optional(string(", "))),
      min: 1
    )
    |> ignore(optional(string("; ")))
    |> wrap()

  game =
    ignore(string("Game "))
    |> integer(min: 1)
    |> ignore(string(": "))
    |> wrap(repeat(round))

  # Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  defparsec(:parse, game |> eos())

  def parse_game(data) do
    data
    |> parse()
    |> to_game()
  end

  defp to_game({:ok, [id, rounds], "", _, _, _}), do: {id, rounds}
end
