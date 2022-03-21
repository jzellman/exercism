defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(cellar, color, opts \\ [])

  def filter([], _, _), do: []

  def filter(cellar, color, opts) do
    cellar
    |> Keyword.get_values(color)
    |> maybe_filter_by_year(opts[:year])
    |> maybe_filter_by_country(opts[:country])
  end

  defp maybe_filter_by_year(bottles, nil), do: bottles
  defp maybe_filter_by_year(bottles, year), do: filter_by_year(bottles, year)

  defp maybe_filter_by_country(bottles, nil), do: bottles
  defp maybe_filter_by_country(bottles, country), do: filter_by_country(bottles, country)

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
