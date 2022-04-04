defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    DateTime.new!(Date.new!(year, month, day), Time.new!(hours, minutes, seconds))
    |> DateTime.add(1_000_000_000, :second)
    |> to_tuple
  end

  defp to_tuple(dt) do
    {{dt.year, dt.month, dt.day}, {dt.hour, dt.minute, dt.second}}
  end
end
