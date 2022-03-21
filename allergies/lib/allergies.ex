defmodule Allergies do
  @allergens ~w[eggs peanuts shellfish strawberries tomatoes chocolate pollen cats]


  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    bits = flags |> to_bits

    @allergens
    |> Enum.with_index
    |> Enum.map(fn({allergen, index}) ->
      if Enum.at(bits, index) == 1 do
        allergen
      end
    end)
    |> Enum.filter(fn a -> a end)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    item in list(flags)
  end

  defp to_bits(flags) do
    flags
    |> Integer.digits(2)
    |> Enum.reverse
  end
end
