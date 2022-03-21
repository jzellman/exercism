defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory
    |> Enum.sort_by(& &1.price)
  end

  def with_missing_price(inventory) do
    inventory
    |> Enum.filter(fn i -> i.price == nil end)
  end

  def increase_quantity(item, count) do
    updated_quantities =
      item
      |> Map.get(:quantity_by_size)
      |> Enum.map(fn {k, v} -> {k, v + count} end)
      |> Map.new()

    Map.put(item, :quantity_by_size, updated_quantities)
  end

  def total_quantity(item) do
    item
    |> Map.get(:quantity_by_size)
    |> Enum.map(fn {k, v} -> v end)
    |> Enum.sum()
  end
end
