defmodule AoC2023.Day19.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/19
  """
  @behaviour AoC2023.Day

  import AoC2023.Day19.Parser

  @impl AoC2023.Day

  def run(data) do
    data
    |> parse_system()
    |> accepted_rating()
  end

  defp accepted_rating({workflows, parts}) do
    {%{"in" => parts}, []}
    |> process(workflows)
    |> Enum.flat_map(&Map.values/1)
    |> Enum.sum()
  end

  defp process({queue, accepted}, _) when queue == %{}, do: accepted

  defp process({queue, accepted}, workflows) do
    queue
    |> Enum.reduce({%{}, accepted}, fn {w, p}, s -> run_workflow(workflows[w], p, s) end)
    |> process(workflows)
  end

  defp run_workflow(workflow, parts, state) do
    parts
    |> Enum.reduce(state, &process_part(&1, workflow, &2))
  end

  defp process_part(part, workflow, state) do
    workflow
    |> Enum.reduce_while(state, &match(&1, part, &2))
  end

  defp match({rate, cmp, limit, workflow}, part, state) do
    if compare(cmp, part[rate], limit),
      do: {:halt, add_match(workflow, part, state)},
      else: {:cont, state}
  end

  defp match(workflow, part, state), do: {:halt, add_match(workflow, part, state)}

  defp add_match("A", part, {queue, accepted}), do: {queue, [part | accepted]}
  defp add_match("R", _, state), do: state

  defp add_match(workflow, part, {queue, accepted}),
    do: {Map.update(queue, workflow, [part], &[part | &1]), accepted}

  defp compare(">", amount, limit), do: amount > limit
  defp compare("<", amount, limit), do: amount < limit
end
