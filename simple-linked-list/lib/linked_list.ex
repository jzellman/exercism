defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    %{next: nil}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    %{next: list, value: elem}
  end

  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count(%{next: nil}), do: 0

  def count(%{next: list, value: _}) do
    1 + count(list)
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list) do
    count(list) == 0
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(%{next: nil}), do: {:error, :empty_list}
  def peek(%{next: _, value: value}), do: {:ok, value}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(%{next: nil}), do: {:error, :empty_list}

  def tail(%{next: list, value: _}) do
    {:ok, list}
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(%{next: nil}), do: {:error, :empty_list}

  def pop(%{next: list, value: value}) do
    {:ok, value, list}
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    list
    |> Enum.reverse()
    |> Enum.reduce(LinkedList.new(), fn el, acc -> LinkedList.push(acc, el) end)
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    to_list(list, [])
  end

  defp to_list(%{next: nil}, acc), do: acc |> Enum.reverse()

  defp to_list(%{next: list, value: value}, acc) do
    to_list(list, [value | acc])
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    reverse(list, new())
  end

  defp reverse(%{next: nil}, reversed), do: reversed

  defp reverse(list, reversed) do
    {:ok, value, tail} = pop(list)
    reverse(tail, push(reversed, value))
  end
end
