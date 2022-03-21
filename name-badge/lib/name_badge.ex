defmodule NameBadge do
  def print(id, name, department) do
    format_id(id) <> format_name(name) <> format_department(department)
  end

  defp format_id(nil), do: ""

  defp format_id(id) do
    "[#{id}] - "
  end

  defp format_name(name) do
    "#{name} - "
  end

  defp format_department(nil), do: format_department("owner")

  defp format_department(department) do
    department |> String.upcase()
  end
end
