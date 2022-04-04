defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) do
    seconds
    |> to_earth_years
    |> to_planet_years(planet)
  end

  defp to_earth_years(seconds) do
    seconds / 60 / 60 / 24 / 365.25
  end

  defp to_planet_years(years, :earth), do: {:ok, years}
  defp to_planet_years(years, :mercury), do: {:ok, years / 0.2408467}
  defp to_planet_years(years, :venus), do: {:ok, years / 0.61519726}
  defp to_planet_years(years, :mars), do: {:ok, years / 1.8808158}
  defp to_planet_years(years, :jupiter), do: {:ok, years / 11.862615}
  defp to_planet_years(years, :saturn), do: {:ok, years / 29.447498}
  defp to_planet_years(years, :uranus), do: {:ok, years / 84.016846}
  defp to_planet_years(years, :neptune), do: {:ok, years / 164.79132}
  defp to_planet_years(_, _), do: {:error, "not a planet"}
end
