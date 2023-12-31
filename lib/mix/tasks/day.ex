defmodule Mix.Tasks.Day do
  use Mix.Task

  @notrim ~w[13]
  @nosplit ~w[5 6 8 19]

  @shortdoc "Run a spefic day with its input"

  def run([day, part]) do
    module =
      Module.safe_concat(~w[ Elixir AoC2023 Day#{String.pad_leading(day, 2, "0")} Part#{part} ])

    case File.read("data/my/day#{String.pad_leading(day, 2, "0")}.txt") do
      {:ok, content} ->
        apply(module, :run, [to_content(day, content)])

      {:error, _} ->
        apply(module, :run, [[]])
    end
    |> IO.puts()
  end

  defp to_content(day, content) do
    if Enum.member?(@nosplit, day) do
      content
    else
      content |> String.split("\n", trim: !Enum.member?(@notrim, day))
    end
  end
end
