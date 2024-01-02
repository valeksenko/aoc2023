defmodule AoC2023.Day24.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/24
    line intersection - https://www.topcoder.com/thrive/articles/Geometry%20Concepts%20part%202:%20%20Line%20Intersection%20and%20its%20Applications#LineLineIntersection
  """
  @behaviour AoC2023.Day

  @impl AoC2023.Day

  def run(data, limits \\ {200_000_000_000_000, 400_000_000_000_000}) do
    data
    |> Enum.map(&parse/1)
    |> combinations(2)
    |> Enum.map(&area_intersection/1)
    |> Enum.count(&in_area?(&1, limits))
  end

  defp area_intersection([path1, path2]),
    do: intersection(line(path1), line(path2)) |> future_only(path1, path2)

  defp future_only(:parallel, _, _), do: :none

  defp future_only({x, y}, [[x1, y1, _], [dx1, dy1, _]], [[x2, y2, _], [dx2, dy2, _]]) do
    if ((x1 > x && dx1 < 0) || (x1 < x && dx1 > 0)) &&
         ((x2 > x && dx2 < 0) || (x2 < x && dx2 > 0)) &&
         ((y1 > y && dy1 < 0) || (y1 < y && dy1 > 0)) &&
         ((y2 > y && dy2 < 0) || (y2 < y && dy2 > 0)),
       do: {x, y},
       else: :none
  end

  defp in_area?(:none, _), do: false

  defp in_area?({x, y}, {min_axis, max_axis}),
    do: min_axis <= x and x <= max_axis && (min_axis <= y and y <= max_axis)

  # Ax+By=C
  defp line([[x, y, _], [dx, dy, _]]), do: {dy, -dx, dy * x + -dx * y}

  defp intersection({a1, b1, c1}, {a2, b2, c2}) do
    case a1 * b2 - a2 * b1 do
      0 -> :parallel
      det -> {(b2 * c1 - b1 * c2) / det, (a1 * c2 - a2 * c1) / det}
    end
  end

  defp parse(input) do
    input
    |> String.split(~r{\s+@\s+})
    |> Enum.map(fn p -> p |> String.split(~r{,\s+}) |> Enum.map(&String.to_integer/1) end)
  end

  defp combinations(_, 0), do: [[]]
  defp combinations([], _), do: []

  defp combinations([h | t], k) do
    (for(l <- combinations(t, k - 1), do: [h | l]) ++ combinations(t, k))
    |> Enum.uniq()
  end
end
