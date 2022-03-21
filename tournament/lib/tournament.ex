defmodule TeamRecord do
  defstruct [:name, win: 0, loss: 0, draw: 0, matches: 0, points: 0]

  def add_game(record, result) do
    key = String.to_atom(result)

    Map.update(record, key, 0, fn ex -> ex + 1 end)
    |> update_points
    |> update_match_count
  end

  def update_points(%{win: wins, draw: draws} = record) do
    Map.put(record, :points, wins * 3 + draws)
  end

  def update_match_count(%{win: wins, loss: losses, draw: draws} = record) do
    Map.put(record, :matches, wins + losses + draws)
  end
end

defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Tournament.Parser.to_team_records()
    |> sort_by_best_record
    |> Tournament.Formatter.to_table()
  end

  defp sort_by_best_record(team_records) do
    team_records
    |> Enum.sort_by(fn tr -> tr.points end, :desc)
  end
end

defmodule Tournament.Parser do
  def to_team_records(input) do
    input
    |> Enum.map(fn line -> String.split(line, ";") end)
    |> Enum.filter(&valid?/1)
    |> Enum.reduce(%{}, fn [team1_name, team2_name, team1_result], acc ->
      acc
      |> add_game_result(team1_name, team1_result)
      |> add_game_result(team2_name, negate_game_result(team1_result))
    end)
    |> Map.values()
  end

  defp add_game_result(results, team_name, game_result) do
    record = Map.get(results, team_name, %TeamRecord{name: team_name})
    record = TeamRecord.add_game(record, game_result)
    Map.put(results, team_name, record)
  end

  defp negate_game_result("win"), do: "loss"
  defp negate_game_result("loss"), do: "win"
  defp negate_game_result("draw"), do: "draw"

  defp valid?([_, _, game_result]) do
    game_result in ["loss", "win", "draw"]
  end

  defp valid?(_), do: false
end

defmodule Tournament.Formatter do
  def to_table(team_records) do
    rows =
      team_records
      |> Enum.map(&format_team_record/1)

    [header_row() | rows] |> Enum.join("\n")
  end

  defp header_row() do
    format_row("Team", "MP", "W", "D", "L", "P")
  end

  defp format_team_record(tr) do
    format_row(tr.name, tr.matches, tr.win, tr.draw, tr.loss, tr.points)
  end

  defp format_row(team, matches, wins, draws, losses, points) do
    [
      String.pad_trailing(team, 30),
      pad_leading(matches, 2),
      pad_leading(wins, 2),
      pad_leading(draws, 2),
      pad_leading(losses, 2),
      pad_leading(points, 2)
    ]
    |> Enum.join(" | ")
  end

  defp pad_leading(n, pad) do
    n
    |> to_string
    |> String.pad_leading(pad)
  end
end
