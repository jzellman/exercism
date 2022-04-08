defmodule BankAccount do
  defstruct open: true, balance: 0

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = Agent.start_link(fn -> %BankAccount{} end)
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    Agent.update(account, fn ba ->
      %{ba | :open => false}
    end)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    Agent.get(account, &get_balance/1)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    Agent.get_and_update(account, fn ba -> update_balance(ba, amount) end)
  end

  defp update_balance(ba = %{open: false}, _) do
    {{:error, :account_closed}, ba}
  end

  defp update_balance(ba, amount) do
    {:ok, %{ba | :balance => ba.balance + amount}}
  end

  defp get_balance(%{open: false}), do: {:error, :account_closed}

  defp get_balance(%{balance: balance}), do: balance
end
