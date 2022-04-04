defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    extract(data, path |> String.split("."))
  end

  def get_in_path(data, path) do
    Kernel.get_in(data, path |> String.split("."))
  end

  defp extract(nil, _), do: nil

  defp extract(data, []), do: data

  defp extract(data, [key | rest]) do
    extract(data[key], rest)
  end
end
