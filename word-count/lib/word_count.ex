defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> words
    |> Enum.reduce(%{}, fn w, map -> increment_word(w, map) end)
  end

  defp words(sentence) do
    Regex.split(~r/( |,|_|:|\.|\n)/, sentence)
    |> Enum.map(fn w -> String.trim(w, "'") end)
    |> Enum.filter(fn w -> w != "" end)
  end

  defp increment_word(word, map) do
    map
    |> Map.update(word, 1, fn existing -> existing + 1 end)
  end
end
