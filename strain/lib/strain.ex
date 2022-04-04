defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    list
    |> keep(fun, [])
    |> reverse([])
  end

  defp keep([], _, res), do: res

  defp keep([hd | tl], fun, res) do
    if fun.(hd) do
      keep(tl, fun, [hd | res])
    else
      keep(tl, fun, res)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    keep(list, fn el -> not fun.(el) end)
  end

  defp reverse([hd | tl], res) do
    reverse(tl, [hd | res])
  end

  defp reverse([], res), do: res
end
