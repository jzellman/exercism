defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(:yacht, [r, r, r, r, r]), do: 50

  def score(:ones, dice), do: score_combo(dice, 1)

  def score(:twos, dice), do: score_combo(dice, 2)

  def score(:threes, dice), do: score_combo(dice, 3)

  def score(:fours, dice), do: score_combo(dice, 4)

  def score(:fives, dice), do: score_combo(dice, 5)

  def score(:sixes, dice), do: score_combo(dice, 6)

  def score(:full_house, dice) do
    by_roll = group_by_roll(dice)

    cond do
      by_roll |> Map.keys() |> length != 2 -> 0
      by_roll |> Map.values() |> Enum.map(&length/1) |> Enum.sort() != [2, 3] -> 0
      true -> dice |> Enum.sum()
    end
  end

  def score(:four_of_a_kind, dice) do
    dice
    |> group_by_roll()
    |> Map.values()
    |> Enum.find(fn rolls -> rolls |> length >= 4 end)
    |> sum_dice(4)
  end

  def score(:little_straight, dice) do
    if straight?(dice, [1, 2, 3, 4, 5]), do: 30, else: 0
  end

  def score(:big_straight, dice) do
    if straight?(dice, [2, 3, 4, 5, 6]), do: 30, else: 0
  end

  def score(:choice, dice), do: Enum.sum(dice)

  def score(_category, _dice), do: 0

  defp group_by_roll(dice) do
    dice |> Enum.group_by(&Integer.digits/1)
  end

  defp straight?(dice, straight) do
    MapSet.subset?(MapSet.new(straight), MapSet.new(dice))
  end

  defp score_combo(dice, num) do
    IO.puts("Scoring #{num} in #{inspect(dice)}")

    dice
    |> Enum.filter(fn die -> die == num end)
    |> Enum.sum()
  end

  defp sum_dice(nil, _dice_to_take), do: 0

  defp sum_dice(dice, dice_to_take), do: dice |> Enum.take(dice_to_take) |> Enum.sum()
end
