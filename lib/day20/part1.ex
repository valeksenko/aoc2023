defmodule AoC2023.Day20.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2023/day/20
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
    @enforce_keys [:queue, :pulses, :config]
    defstruct @enforce_keys
    @type t :: %__MODULE__{queue: List.t(), pulses: Tuple.t(), config: Map.t()}
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
    |> push_button(1_000)
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

  defp push_button(configuration, pushes) do
    1..pushes
    |> Enum.reduce(%State{queue: [], pulses: {0, 0}, config: configuration}, fn _, s ->
      s |> send(:button, @low) |> relay()
    end)
    |> (fn s -> Tuple.product(s.pulses) end).()
  end

  defp relay(state = %State{queue: []}), do: state

  defp relay(state) do
    state.queue
    |> Enum.reduce(register_pulses(state), fn {i, m, b}, s -> deliver(s.config[m], i, b, s) end)
    |> relay()
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

  defp register_pulses(state),
    do: %{
      state
      | queue: [],
        pulses:
          Enum.reduce(state.queue, state.pulses, fn {_, _, i}, p ->
            put_elem(p, i, elem(p, i) + 1)
          end)
    }

  defp send(state, id, pulse),
    do: %{
      state
      | queue: state.config[id].output |> Enum.map(&{id, &1, pulse}) |> Enum.concat(state.queue)
    }
end
