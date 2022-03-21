defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    list
    |> Enum.reduce([], fn el, acc ->
      if is_list(el) do
        acc ++ flatten(el)
      else
        acc ++ [el]
      end
    end)
    |> Enum.reject(&is_nil/1)
  end
end
