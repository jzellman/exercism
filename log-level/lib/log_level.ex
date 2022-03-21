defmodule LogLevel do
  def to_label(0, true), do: :unknown
  def to_label(0, _), do: :trace
  def to_label(1, _), do: :debug
  def to_label(2, _), do: :info
  def to_label(3, _), do: :warning
  def to_label(4, _), do: :error
  def to_label(5, true), do: :unknown
  def to_label(5, _), do: :fatal
  def to_label(_, _), do: :unknown

  def alert_recipient(level, legacy?) do
    to_label(level, legacy?)
    |> maybe_alert(legacy?)
  end

  defp maybe_alert(:error, _), do: :ops
  defp maybe_alert(:fatal, _), do: :ops
  defp maybe_alert(:unknown, true), do: :dev1
  defp maybe_alert(:unknown, false), do: :dev2
  defp maybe_alert(_, _), do: false
end
