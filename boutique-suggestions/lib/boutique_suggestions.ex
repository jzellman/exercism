defmodule BoutiqueSuggestions do
  @default_max_price 100

  def get_combinations(tops, bottoms, options \\ []) do
    for top <- tops, bottom <- bottoms, qualifies?(top, bottom, options), do: {top, bottom}
  end

  defp qualifies?(top, bottom, options) do
    not clash?(top, bottom) and can_afford?(top, bottom, options[:maximum_price])
  end

  defp can_afford?(%{price: top_price}, %{price: bottom_price}, max) do
    max = max || @default_max_price
    top_price + bottom_price <= max
  end

  defp clash?(%{base_color: top_color}, %{base_color: bottom_color}) do
    top_color == bottom_color
  end
end
