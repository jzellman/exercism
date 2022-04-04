defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    factors_for(number, [])
    |> Enum.sort()
  end

  defp factors_for(1, acc), do: acc

  defp factors_for(number, acc) do
    found =
      2..number
      |> Stream.filter(fn x -> rem(number, x) == 0 end)
      |> Enum.take(1)
      |> Enum.at(0)

    if found == nil do
      acc
    else
      factors_for(div(number, found), [found | acc])
    end
  end
end
