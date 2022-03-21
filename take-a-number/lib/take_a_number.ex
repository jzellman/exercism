defmodule TakeANumber do
  def start() do
    spawn(TakeANumber, :loop, [0])
  end

  def loop(number) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, number)
        loop(number)

      {:take_a_number, sender_pid} ->
        number = number + 1
        send(sender_pid, number)
        loop(number)

      :stop ->
        Process.exit(self(), :normal)

      _ ->
        loop(number)
    end
  end
end
