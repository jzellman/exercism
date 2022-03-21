defmodule Transpose do
  @space_sentinel "<sentinel>"

  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    {rows, max_length} = char_rows(input)

    1..max_length
    |> Enum.map(fn i -> to_column(rows, i - 1) end)
    |> Enum.join("\n")
    |> String.trim()
  end

  defp to_column(rows, column_index) do
    # space sentinel is used to signify white spaced.
    # All trailing sentinel spaces shoudl be trimmed
    # however if the original input contained a space 
    # we do not wnat to trim that
    #
    rows
    |> Enum.map(fn row ->
      Enum.at(row, column_index) || @space_sentinel
    end)
    |> Enum.join("")
    |> String.trim_trailing(@space_sentinel)
    |> String.replace(@space_sentinel, " ")
  end

  defp char_rows(input) do
    rows = to_rows(input)
    {rows, max_row_lenth(rows)}
  end

  defp to_rows(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
  end

  defp max_row_lenth(rows) do
    rows
    |> Enum.map(fn r -> length(r) end)
    |> Enum.max()
  end
end
