defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cleaned =
      input
      |> String.trim()

    is_question = String.ends_with?(cleaned, "?")
    is_yelling = yelling?(cleaned)
    is_blank = cleaned == ""

    cond do
      is_blank -> "Fine. Be that way!"
      is_question and is_yelling -> "Calm down, I know what I'm doing!"
      is_yelling -> "Whoa, chill out!"
      is_question -> "Sure."
      true -> "Whatever."
    end
  end

  defp yelling?(input) do
    input == String.upcase(input) and not only_numbers?(input)
  end

  defp only_numbers?(input) do
    no_punctuation = Regex.replace(~r/[,.!?:) ]/, input, "")
    Regex.match?(~r/^[0-9]*$/, no_punctuation)
  end
end
