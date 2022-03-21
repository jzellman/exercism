defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase()
    |> String.graphemes()
    |> Enum.map(&score_letter/1)
    |> Enum.sum()
  end

  defp score_letter(letter) when letter in ~w(A E I O U L N R S T), do: 1
  defp score_letter(letter) when letter in ~w(D G), do: 2
  defp score_letter(letter) when letter in ~w(B C M P), do: 3
  defp score_letter(letter) when letter in ~w(F H V W Y), do: 4
  defp score_letter(letter) when letter in ~w(K), do: 5
  defp score_letter(letter) when letter in ~w(J X), do: 8
  defp score_letter(letter) when letter in ~w(Q Z), do: 10
  defp score_letter(_), do: 0
end
