defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> maybe_push_command(0x08 === (code &&& 0x08), "jump")
    |> maybe_push_command(0x04 === (code &&& 0x04), "close your eyes")
    |> maybe_push_command(0x02 === (code &&& 0x02), "double blink")
    |> maybe_push_command(0x01 === (code &&& 0x01), "wink")
    |> maybe_reverse_commands(0x10 === (code &&& 0x10))
  end

  defp maybe_push_command(acc, true, command), do: [command | acc]
  defp maybe_push_command(acc, false, _), do: acc

  defp maybe_reverse_commands(acc, true), do: acc |> Enum.reverse()
  defp maybe_reverse_commands(acc, false), do: acc
end
