defmodule CustomSet do
  defstruct map: %{}

  @opaque t :: %__MODULE__{map: map}

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    map =
      enumerable
      |> Enum.zip(enumerable)
      |> Map.new()

    %CustomSet{map: map}
  end

  @spec empty?(t) :: boolean
  def empty?(%{map: map}) do
    map_size(map) == 0
  end

  @spec contains?(t, any) :: boolean
  def contains?(%{map: map}, element) do
    Map.get(map, element) != nil
  end

  @spec subset?(t, t) :: boolean
  def subset?(%{map: map1}, %{map: map2}) do
    map1
    |> Map.keys()
    |> Enum.all?(fn key -> Map.get(map2, key) end)
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    intersection(custom_set_1, custom_set_2)
    |> empty?
  end

  @spec equal?(t, t) :: boolean
  def equal?(%{map: map}, %{map: map}), do: true
  def equal?(_, _), do: false

  @spec add(t, any) :: t
  def add(%{map: map}, element) do
    CustomSet.new([element | map |> Map.keys()])
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    custom_set_1
    |> split(custom_set_2)
    |> elem(0)
    |> CustomSet.new()
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    custom_set_1
    |> split(custom_set_2)
    |> elem(1)
    |> CustomSet.new()
  end

  @spec union(t, t) :: t
  def union(custom_set, %{map: map2}) do
    map2
    |> Map.keys()
    |> Enum.reduce(custom_set, fn el, set -> add(set, el) end)
  end

  defp split(%{map: map1}, custom_set_2) do
    map1
    |> Map.keys()
    |> Enum.split_with(fn key -> CustomSet.contains?(custom_set_2, key) end)
  end
end
