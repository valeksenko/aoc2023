defmodule AoC2023.Day20.Parser do
  import NimbleParsec

  module = ascii_string([?a..?z], min: 1)
  qualifier = ascii_string([?%, ?&], 1)

  configuration =
    optional(qualifier)
    |> concat(module)
    |> ignore(string(" -> "))
    |> wrap(
      repeat(
        module
        |> ignore(optional(string(", ")))
      )
    )

  # %a -> inv, con
  defparsec(:parse, configuration |> eos())

  def parse_configuration(data) do
    data
    |> parse()
    |> to_configuration()
  end

  defp to_configuration({:ok, [qual, input, output], "", _, _, _}), do: {qual, input, output}
  defp to_configuration({:ok, [input, output], "", _, _, _}), do: {"=", input, output}
end
