defmodule ResistorColorDuo do
  @colors [:black, :brown, :red, :orange, :yellow, :green, :blue, :violet, :grey, :white]

  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value([first, second | _]) do
    [first, second]
    |> Stream.map(&color_index/1)
    |> Stream.map(&to_string/1)
    |> Enum.join("")
    |> String.to_integer
  end

  defp color_index(color) do
    @colors
    |> Enum.find_index(fn c -> c == color end)
  end
end
