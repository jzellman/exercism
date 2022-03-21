defmodule Lasagna do
  @minutes_in_oven 40
  @minutes_per_layer 2

  def expected_minutes_in_oven, do: @minutes_in_oven

  def remaining_minutes_in_oven(time_in_oven) do
    expected_minutes_in_oven - time_in_oven
  end

  def preparation_time_in_minutes(layers) do
    layers * @minutes_per_layer
  end

  def total_time_in_minutes(layers, time_in_oven) do
    preparation_time_in_minutes(layers) + time_in_oven
  end

  def alarm, do: "Ding!"
end
