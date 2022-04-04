defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: any()

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new() do
    Map.new()
  end

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    maybe_add_student(school, name, grade, name in roster(school))
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    school
    |> Map.get(grade, [])
    |> Enum.sort()
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    1..12
    |> Enum.flat_map(fn grade_level -> grade(school, grade_level) end)
  end

  defp maybe_add_student(school, name, grade, true), do: {:error, school}

  defp maybe_add_student(school, name, grade, false) do
    {:ok, Map.update(school, grade, [name], fn existing -> [name | existing] end)}
  end
end
