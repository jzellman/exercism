# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  defstruct next_id: 1, plots: []

  def start(opts \\ []) do
    # TODO there is a subtle bug here, we should first check the passed in
    # opts, assuming they are plots to find the next plot id
    Agent.start_link(fn -> %CommunityGarden{plots: opts} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn %{plots: plots} -> plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn garden = %{plots: plots, next_id: next_id} ->
      plot = %Plot{:registered_to => register_to, :plot_id => next_id}
      new_garden = %{garden | :next_id => next_id + 1, :plots => [plot | plots]}
      {plot, new_garden}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn garden ->
      new_plots =
        garden.plots
        |> Enum.filter(fn plot -> plot.plot_id != plot_id end)

      %{garden | :plots => new_plots}
    end)

    :ok
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn garden ->
      garden.plots
      |> Enum.find(fn plot -> plot.plot_id == plot_id end)
    end) || {:not_found, "plot is unregistered"}
  end
end
