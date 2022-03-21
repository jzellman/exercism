defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    if length(strand1) != length(strand2) do
      {:error, "strands must be of equal length"}
    else
      {:ok, diff_count(strand1, strand2)}
    end
  end

  defp diff_count(strand1, strand2) do
    Enum.zip_reduce(strand1, strand2, 0, fn x, y, acc ->
      if x != y, do: acc + 1, else: acc
    end)
  end
end
