defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    @planetary_classes |> Enum.random()
  end

  def random_ship_registry_number() do
    "NCC-#{Enum.random(1000..9999)}"
  end

  def random_stardate() do
    Enum.random(41000..42000) + :rand.uniform()
  end

  def format_stardate(stardate) when is_float(stardate) do
    "~.1f"
    |> :io_lib.format([stardate])
    |> to_string()
  end

  def format_stardate(_), do: raise(ArgumentError)
end
