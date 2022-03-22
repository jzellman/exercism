defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, _, output_base) when output_base < 2 do
    {:error, "output base must be >= 2"}
  end

  def convert(_, input_base, _) when input_base < 2 do
    {:error, "input base must be >= 2"}
  end

  def convert(digits, input_base, output_base) do
    do_conversion(digits, input_base, output_base, bad_digits?(digits, input_base))
  end

  defp do_conversion(_, _, _, true) do
    {:error, "all digits must be >= 0 and < input base"}
  end

  defp do_conversion(digits, input_base, output_base, _) do
    converted =
      digits
      |> Integer.undigits(input_base)
      |> Integer.digits(output_base)

    {:ok, converted}
  end

  defp bad_digits?(digits, input_base) do
    Enum.any?(digits, fn d -> d < 0 or d >= input_base end)
  end
end
