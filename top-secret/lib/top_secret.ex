defmodule TopSecret do
  def to_ast(string) do
    string |> Code.string_to_quoted!()
  end

  def decode_secret_message_part({token, _, body} = ast, acc) when token in [:defp, :def] do
    {ast, [get_message(body) | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  def decode_secret_message(string) do
    string
    |> to_ast
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> extract_message_parts()
  end

  defp get_message([{:when, _, params} | _]) do
    params |> get_message()
  end

  defp get_message([{_, _, nil} | _]), do: ""

  defp get_message([{token, _, params} | _]) do
    message_length = params |> length

    token
    |> to_string
    |> String.slice(0, message_length)
  end

  defp extract_message_parts({_, message_parts}) do
    message_parts
    |> Enum.reverse()
    |> Enum.join("")
  end
end
