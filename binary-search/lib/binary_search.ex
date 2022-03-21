defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    search(numbers, key, 0, tuple_size(numbers))
  end

  def search(_, _, _, 0) do
    :not_found
  end

  def search(numbers, key, lower_bound, upper_bound) do
    index = div(upper_bound - lower_bound, 2) + lower_bound

    element = elem(numbers, index)

    cond do
      element != key and upper_bound - lower_bound <= 1 ->
        :not_found

      element < key ->
        search(numbers, key, index, upper_bound)

      element == key ->
        {:ok, index}

      element > key ->
        search(numbers, key, 0, index)
    end
  end
end
