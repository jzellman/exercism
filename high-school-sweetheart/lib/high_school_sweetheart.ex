defmodule HighSchoolSweetheart do
  def first_letter(name) do
    name
    |> String.strip()
    |> String.first()
  end

  def initial(name) do
    initial =
      name
      |> first_letter
      |> String.capitalize()

    "#{initial}."
  end

  def initials(full_name) do
    full_name
    |> String.split()
    |> Enum.map(fn n -> initial(n) end)
    |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{initials(full_name1)}  +  #{initials(full_name2)}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
