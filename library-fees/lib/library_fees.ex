defmodule LibraryFees do
  def datetime_from_string(string) do
    string
    |> NaiveDateTime.from_iso8601!()
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    days_to_add = if before_noon?(checkout_datetime), do: 28, else: 29

    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(days_to_add)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    diff = Date.diff(actual_return_datetime, planned_return_date)
    if diff < 0, do: 0, else: diff
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    planned_return_date =
      checkout
      |> datetime_from_string
      |> return_date

    actual_return_date =
      return
      |> datetime_from_string

    fee = days_late(planned_return_date, actual_return_date) * rate
    maybe_apply_discount(fee, monday?(actual_return_date))
  end

  defp maybe_apply_discount(fee, true), do: :math.floor(fee * 0.5)

  defp maybe_apply_discount(fee, false), do: fee
end
