defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position :: position) :: integer
  def score({x, y}) do
    :math.sqrt(x * x + y * y)
    |> calculate()
  end

  defp calculate(distance) when distance <= 1, do: 10
  defp calculate(distance) when distance <= 5, do: 5
  defp calculate(distance) when distance <= 10, do: 1
  defp calculate(_), do: 0
end
