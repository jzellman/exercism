defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> encode_chars("", 1, [])
    |> Enum.join("")
  end

  defp encode_chars([hd | tl], char, count, res) do
    if hd == char do
      encode_chars(tl, char, count + 1, res)
    else
      encode_chars(tl, hd, 1, [res, encode_char(char, count)])
    end
  end

  defp encode_chars([], char, count, res) do
    [res, encode_char(char, count)]
  end

  defp encode_char(char, 1), do: char
  defp encode_char(char, n), do: "#{n}#{char}"

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    ~r/\d*./
    |> Regex.scan(string)
    |> Enum.map(fn p -> decode_part(p) end)
    |> Enum.join("")
  end

  defp decode_part([part]) do
    case Integer.parse(part) do
      :error -> part
      {count, char} -> expand(char, count)
    end
  end

  defp expand(char, count) do
    1..count
    |> Enum.map(fn _ -> char end)
    |> Enum.join("")
  end
end
