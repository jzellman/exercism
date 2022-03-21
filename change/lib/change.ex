defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(_, 0), do: {:ok, []}

  def generate(denominations, target) do
    cache = Enum.reduce((1..target), %{}, fn t, cache ->
      best = least_coins_for(denominations, t, cache)
      Map.put(cache, t, best)
    end)

    minimum_coins = Map.get(cache, target)

    if minimum_coins do
      {:ok, minimum_coins}
    else
      {:error, "cannot change"}
    end
  end

  def least_coins_for(denominations, target, cache) do
    denominations
    |> Enum.map(fn d ->
      index = target - d
      if index > -1 do
        [d | Map.get(cache, index) || []]
      else
        nil
      end
    end)
    # |> IO.inspect
    |> Enum.filter(fn comp -> comp end)
    |> Enum.filter(fn comp -> Enum.sum(comp) == target end)
    |> Enum.sort_by(fn comp -> length(comp) end)
    |> Enum.at(0)
  end
end
