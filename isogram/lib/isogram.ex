defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.downcase()
    |> String.graphemes()
    |> letters_only
    |> is_isogram?([])
  end

  defp is_isogram?([], _), do: true

  defp is_isogram?([hd | tl], seen) do
    if hd not in seen do
      is_isogram?(tl, [hd | seen])
    else
      false
    end
  end

  defp letters_only(chars) do
    chars
    |> Enum.filter(fn ch -> ch >= "a" and ch <= "z" end)
  end
end
