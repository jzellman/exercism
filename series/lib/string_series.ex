defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    slices(s, String.length(s), size)
  end

  def slices(_s, s_length, size)
      when s_length < size
      when size < 1,
      do: []

  def slices(s, s_length, size) do
    upto = s_length - size

    0..upto
    |> Enum.map(fn index -> String.slice(s, index, size) end)
  end
end
