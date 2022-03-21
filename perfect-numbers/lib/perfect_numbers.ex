defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number > 0 do
    number
    |> factors
    |> Enum.sum()
    |> classify(number)
  end

  def classify(_), do: {:error, "Classification is only possible for natural numbers."}

  defp factors(1), do: []

  defp factors(number) do
    1..(number - 1)
    |> Enum.filter(fn n -> rem(number, n) == 0 end)
  end

  defp classify(sum, number) when sum == number, do: {:ok, :perfect}
  defp classify(sum, number) when sum > number, do: {:ok, :abundant}
  defp classify(sum, number) when sum < number, do: {:ok, :deficient}
end
