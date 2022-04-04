defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]) do
    ""
  end

  def recite(lst = [hd | _]) do
    verses =
      lst
      |> recite([])
      |> Enum.reverse()
      |> Kernel.++(["And all for the want of a #{hd}.\n"])
      |> Enum.join("\n")
  end

  defp recite([first, second | rest], res) do
    recite([second | rest], ["For want of a #{first} the #{second} was lost." | res])
  end

  defp recite(_, res), do: res
end
