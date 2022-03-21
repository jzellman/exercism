defmodule Username do
  def sanitize(username) do
    username |> clean('')
  end

  defp clean([], result) do
    result
  end

  defp clean([ch | remaining_chars], result) do
    replacement =
      case ch do
        ?ä -> 'ae'
        ?ö -> 'oe'
        ?ü -> 'ue'
        ?ß -> 'ss'
        ?_ -> [ch]
        ch when ch >= ?a and ch <= ?z -> [ch]
        _ -> ''
      end

    clean(remaining_chars, result ++ replacement)
  end
end
