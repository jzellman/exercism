defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a == b -> :equal
      a == [] -> :sublist
      b == [] -> :superlist
      contains(a, b) -> :sublist
      contains(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp contains(a, b) do
    length_a = length(a)
    length_b = length(b)

    if length_b < length_a do
      false
    else
      check_sublist({a, length_a}, b)
    end
  end

  defp check_sublist({a, length_a}, [hd | tl]) do
    cond do
      # this is an optimization to prevent spinning forever
      length(tl) + 1 < length_a -> false
      a === [hd | Enum.take(tl, length_a - 1)] -> true
      true -> check_sublist({a, length_a}, tl)
    end
  end

  defp check_sublist(_, []), do: false
end
