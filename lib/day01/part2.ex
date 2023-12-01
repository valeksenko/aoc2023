defmodule AoC2023.Day01.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/1#part2
  """
  @behaviour AoC2023.Day

  @translations %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9",
  }

  @impl AoC2023.Day

  def run(data) do
    data
    |> Enum.map(&translate/1)
    |> Enum.map(&to_digits/1)
    |> Enum.map(&to_number/1)
    |> Enum.sum()
  end

  defp translate(input) do
    input
    |> String.graphemes()
    |> word_to_digit()
    |> List.to_string()
  end

  defp word_to_digit([]), do: []
  defp word_to_digit(input) do
    @translations
    |> Enum.reduce(input, &detect_word/2)
    |> (fn [head | tail] -> [head | word_to_digit(tail)] end).()
  end

  defp detect_word({word, digit}, input) do
    if List.starts_with?(input, String.graphemes(word)), do: [digit | tl(input)], else: input
  end

  defp to_digits(input) do
    Regex.scan(~r{\d}, input)
    |> List.flatten()
  end

  defp to_number(digits) do
    (hd(digits) <> List.last(digits))
    |> String.to_integer()
  end
end
