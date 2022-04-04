defmodule Newsletter do
  def read_emails(path) do
    path
    |> File.read!()
    |> String.split("\n")
    |> Enum.filter(fn s -> s != "" end)
  end

  def open_log(path) do
    {:ok, pid} = File.open(path, [:write])
    pid
  end

  def log_sent_email(pid, email) do
    IO.write(pid, email <> "\n")
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    emails_path
    |> read_emails
    |> send_emails(log_path, send_fun)
  end

  defp send_emails(emails, log_path, send_fun) do
    log = open_log(log_path)

    emails
    |> Enum.each(fn email ->
      send_fun.(email)
      |> maybe_log_sent(log, email)
    end)

    close_log(log)
  end

  defp maybe_log_sent(:ok, log, email) do
    log_sent_email(log, email)
  end

  defp maybe_log_sent(_, _, _), do: nil
end
