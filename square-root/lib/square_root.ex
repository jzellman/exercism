defmodule SquareRoot do
  @max_iterations 100
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    radicand
    |> square_root(1, 1)
  end

  defp square_root(_, guess, iteration) when iteration == @max_iterations, do: guess

  defp square_root(radicand, guess, iteration) do
    next_guess = (radicand / guess + guess) / 2

    if next_guess == guess do
      guess
    else
      square_root(radicand, next_guess, iteration + 1)
    end
  end
end
