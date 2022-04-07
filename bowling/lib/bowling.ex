defmodule Bowling do
  defmodule Frame do
    defstruct [:roll1, :roll2]
  end

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game.

    Internally the game is just a map where each key represents the frame number.
    In the case where spare or strike occurs in the last frame, additional 
    (11 and 12) frames may exist in the game map.
  """
  @spec start() :: any
  def start do
    %{1 => %Frame{}}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful error tuple.
  """

  @spec roll(any, integer) :: {:ok, any} | {:error, String.t()}
  def roll(game, roll) do
    {frame_number, frame} = current_frame(game)

    cond do
      game_over?(game) ->
        {:error, "Cannot roll after game is over"}

      roll < 0 ->
        {:error, "Negative roll is invalid"}

      roll > 10 ->
        {:error, "Pin count exceeds pins on the lane"}

      frame.roll1 == nil ->
        {:ok, Map.put(game, frame_number, %{frame | :roll1 => roll})}

      frame.roll1 != 10 and frame.roll2 == nil and frame.roll1 + roll > 10 ->
        {:error, "Pin count exceeds pins on the lane"}

      frame.roll1 != 10 and frame.roll2 == nil ->
        {:ok, Map.put(game, frame_number, %{frame | roll2: roll})}

      frame.roll1 == 10 ->
        {:ok, Map.put(game, frame_number + 1, %Frame{:roll1 => roll})}

      frame.roll2 != nil ->
        {:ok, Map.put(game, frame_number + 1, %Frame{:roll1 => roll})}
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful error tuple.
  """

  @spec score(any) :: {:ok, integer} | {:error, String.t()}
  def score(game) do
    scores = Enum.map(1..10, fn frame_number -> score(frame_number, game) end)

    if Enum.any?(scores, fn score -> score == :error end) do
      {:error, "Score cannot be taken until the end of the game"}
    else
      {:ok, Enum.sum(scores)}
    end
  end

  defp game_over?(game) do
    {result, _} = score(game)
    result == :ok
  end

  defp score(frame_number, game) do
    with {:ok, frame} <- Map.fetch(game, frame_number) do
      score_frame(frame, frame_number, game)
    end
  end

  defp score_frame(%{:roll1 => 10}, frame_number, game) do
    with {:ok, bonus1} <- next_roll(Map.get(game, frame_number + 1)),
         {:ok, bonus2} <-
           next_next_roll(Map.get(game, frame_number + 1), Map.get(game, frame_number + 2)) do
      10 + bonus1 + bonus2
    end
  end

  defp score_frame(%{:roll1 => roll1, :roll2 => roll2}, frame_number, game)
       when is_number(roll1) and is_number(roll2) and roll1 + roll2 == 10 do
    with {:ok, bonus1} <- next_roll(Map.get(game, frame_number + 1)) do
      10 + bonus1
    end
  end

  defp score_frame(%{:roll1 => roll1, :roll2 => roll2}, _, _)
       when is_number(roll1) and is_number(roll2),
       do: roll1 + roll2

  defp score_frame(_, _, _), do: :error

  defp next_roll(%{:roll1 => roll1}) when is_number(roll1), do: {:ok, roll1}

  defp next_roll(frame), do: :error

  defp next_next_roll(%{:roll2 => roll2}, _) when is_number(roll2), do: {:ok, roll2}

  defp next_next_roll(%{:roll2 => nil}, %{:roll1 => roll1}) when is_number(roll1),
    do: {:ok, roll1}

  defp next_next_roll(_, _), do: :error

  defp current_frame(game) do
    latest_frame_number =
      game
      |> Map.keys()
      |> Enum.max()

    {latest_frame_number, Map.get(game, latest_frame_number)}
  end
end
