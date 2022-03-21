defmodule BirdCount do
  def today([]), do: nil

  def today([today | _]) do
    today
  end

  def increment_day_count([]), do: [1]

  def increment_day_count([hd | tl]) do
    [hd + 1 | tl]
  end

  def has_day_without_birds?([]), do: false

  def has_day_without_birds?([hd | tl]) do
    hd == 0 || has_day_without_birds?(tl)
  end

  def total([]), do: 0

  def total([hd | tl]) do
    hd + total(tl)
  end

  def busy_days(list) do
    count_busy_days(list, 0)
  end

  defp count_busy_days([], count), do: count

  defp count_busy_days([hd | tl], count) do
    if hd >= 5 do
      count_busy_days(tl, count + 1)
    else
      count_busy_days(tl, count)
    end
  end
end
