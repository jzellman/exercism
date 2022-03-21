defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> clean_string
    |> String.split(" ")
    |> abbreviate_words()
  end

  defp abbreviate_words(words) do
    words
    |> Enum.map(fn w -> abbreviate_word(w) end)
    |> Enum.filter(fn l -> is_letter(l) end)
    |> Enum.join("")
  end

  defp clean_string(string) do
    string
    |> String.replace("_", " ")
    |> String.replace("-", " ")
  end

  defp abbreviate_word(word) do
    word
    |> String.graphemes()
    |> Enum.take(1)
    |> Enum.join("")
    |> String.upcase()
  end

  defp is_letter(ch) do
    ch >= "A" and ch <= "Z"
  end
end
