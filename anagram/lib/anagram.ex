defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    lower_base =
      base
      |> String.downcase()

    master =
      base
      |> fingerprint

    candidates
    |> Stream.filter(fn c -> lower_base != c |> String.downcase() end)
    |> Stream.filter(fn c -> master == c |> fingerprint end)
    |> Enum.to_list()
  end

  defp fingerprint(word) do
    word
    |> String.downcase()
    |> to_charlist
    |> Enum.sort()
    |> to_string
  end
end
