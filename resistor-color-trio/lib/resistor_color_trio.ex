defmodule ResistorColorTrio do
  @colors [:black, :brown, :red, :orange, :yellow, :green, :blue, :violet, :grey, :white]

  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label(colors) do
    colors
    |> to_number_value
    |> add_label
  end

  defp to_number_value([first, second, third]) do
    (decode([first, second]) <> zero_pad(third))
    |> String.to_integer()
  end

  defp add_label(ohms) do
    if ohms < 1000 do
      {ohms, :ohms}
    else
      kohms = (ohms / 1000) |> Kernel.trunc()
      {kohms, :kiloohms}
    end
  end

  def decode(colors) do
    colors
    |> Enum.map(&color_index/1)
    |> Enum.join("")
  end

  defp zero_pad(color) do
    zero_pad(color_index(color), "")
  end

  defp zero_pad(0, acc), do: acc

  defp zero_pad(n, acc), do: zero_pad(n - 1, "0" <> acc)

  defp color_index(color) do
    @colors
    |> Enum.find_index(fn c -> c == color end)
  end
end
