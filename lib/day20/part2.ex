defmodule AoC2023.Day20.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/20#part2
  """
  @behaviour AoC2023.Day

  import AoC2023.Day20.Parser

  defmodule CommunicationModule do
    @enforce_keys [:id, :type, :output, :input, :on]
    defstruct @enforce_keys

    @type t :: %__MODULE__{
            id: String.t(),
            type: String.t(),
            output: List.t(),
            input: Map.t(),
            on: Boolean.t()
          }
  end

  defmodule State do
    @enforce_keys [:queue, :config]
    defstruct @enforce_keys
    @type t :: %__MODULE__{queue: List.t(), config: Map.t()}
  end

  @impl AoC2023.Day

  @low 0
  @high 1

  @flipflop "%"
  @conjunction "&"

  def run(data) do
    data
    |> Enum.map(&parse_configuration/1)
    |> to_module_configuration()
    |> push_button()
  end

  defp to_module_configuration(configuration) do
    configuration
    |> Enum.reduce(
      %{
        button: %CommunicationModule{
          id: :button,
          type: ">",
          output: ["broadcaster"],
          input: %{},
          on: false
        }
      },
      fn {t, i, o}, m ->
        Map.put(m, i, %CommunicationModule{
          id: i,
          type: t,
          output: o,
          input: connected(t, i, configuration),
          on: false
        })
      end
    )
  end

  defp connected(@conjunction, id, configuration) do
    configuration
    |> Enum.filter(&(id in elem(&1, 2)))
    |> Enum.map(&{elem(&1, 1), @low})
    |> Map.new()
  end

  defp connected(_, _, _), do: %{}

  defp push_button(configuration) do
    %State{queue: [], config: configuration}
    |> Stream.iterate(&(&1 |> send(:button, @low) |> relay()))
    |> Stream.with_index()
    |> Stream.drop_while(fn {s, i} -> inspect_state(s, i) != :received && i != 20 end)
    |> Enum.take(1)
    |> hd()
    |> elem(1)
  end

  defp relay(state = %State{queue: []}), do: state

  defp relay(state) do
    case Enum.any?(state.queue, &match?({_, "rx", @low}, &1)) do
      true ->
        :received

      false ->
        state.queue
        |> Enum.reduce(%{state | queue: []}, fn {i, m, b}, s -> deliver(s.config[m], i, b, s) end)
        |> relay()
    end
  end

  defp deliver(mod, :button, beam, state), do: send(state, mod.id, beam)

  defp deliver(nil, _, _, state), do: state

  defp deliver(%CommunicationModule{type: @flipflop}, _, @high, state), do: state

  defp deliver(mod = %CommunicationModule{type: @flipflop}, _, @low, state),
    do: %{
      send(state, mod.id, if(mod.on, do: @low, else: @high))
      | config: Map.replace(state.config, mod.id, %{state.config[mod.id] | on: !mod.on})
    }

  defp deliver(mod = %CommunicationModule{type: @conjunction}, src, beam, state) do
    s = %{
      state
      | config:
          Map.replace(state.config, mod.id, %{
            state.config[mod.id]
            | input: Map.replace(mod.input, src, beam)
          })
    }

    send(
      s,
      mod.id,
      if(Enum.all?(Map.values(s.config[mod.id].input), &(&1 == @high)), do: @low, else: @high)
    )
  end

  defp send(state, id, pulse),
    do: %{
      state
      | queue: state.config[id].output |> Enum.map(&{id, &1, pulse}) |> Enum.concat(state.queue)
    }

  def inspect_state(state, i) do
    IO.binwrite("*** Step #{i}\n\n")

    state.config
    |> Map.values()
    |> Enum.each(fn m ->
      IO.binwrite(
        "#{m.type} #{m.id} -> #{m.on} -> #{inspect(m.output)} -> #{inspect(Map.keys(m.input))} -> #{m.input |> Map.values() |> Enum.join()} \n"
      )
    end)

    IO.binwrite("\n\n")

    state
  end
end
