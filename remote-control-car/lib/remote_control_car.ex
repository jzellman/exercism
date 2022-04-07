defmodule RemoteControlCar do
  @enforce_keys [:nickname]

  defstruct battery_percentage: 100, distance_driven_in_meters: 0, nickname: nil

  def new() do
    new("none")
  end

  def new(nickname) do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(remote_car = %RemoteControlCar{}) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(remote_car = %RemoteControlCar{battery_percentage: 0}) do
    "Battery empty"
  end

  def display_battery(remote_car = %RemoteControlCar{battery_percentage: percent}) do
    "Battery at #{percent}%"
  end

  def drive(remote_car = %RemoteControlCar{battery_percentage: 0}) do
    remote_car
  end

  def drive(
        remote_car = %RemoteControlCar{
          battery_percentage: percent,
          distance_driven_in_meters: distance
        }
      ) do
    %{remote_car | distance_driven_in_meters: distance + 20, battery_percentage: percent - 1}
  end
end
