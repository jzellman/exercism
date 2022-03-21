defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove(list) do
    [hd | tl] = list
    tl
  end

  def first(list) do
    [hd | tl] = list
    hd
  end

  def count(list) do
    count(list, 0)
  end

  def exciting_list?(list) do
    [hd | tl] = list

    cond do
      hd == "Elixir" -> true
      tl == [] -> false
      true -> exciting_list?(tl)
    end
  end

  defp count([hd | tl], acc) do
    count(tl, acc + 1)
  end

  defp count([], acc) do
    acc
  end
end
