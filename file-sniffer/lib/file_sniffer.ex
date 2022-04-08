defmodule FileSniffer do
  @extensions %{
    "bmp" => "image/bmp",
    "gif" => "image/gif",
    "jpg" => "image/jpg",
    "png" => "image/png",
    "exe" => "application/octet-stream"
  }

  def type_from_extension(extension) do
    Map.get(@extensions, extension)
  end

  def type_from_binary(<<0x42, 0x4D, _::binary>>), do: type_from_extension("bmp")

  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _::binary>>), do: type_from_extension("exe")

  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>),
    do: type_from_extension("png")

  def type_from_binary(<<0xFF, 0xD8, 0xFF, _::binary>>), do: type_from_extension("jpg")

  def type_from_binary(<<0x47, 0x49, 0x46, _::binary>>), do: type_from_extension("gif")

  def verify(file_binary, extension) do
    verify_tuple(type_from_binary(file_binary), type_from_extension(extension))
  end

  defp verify_tuple(computed_type, expected_type) when computed_type == expected_type,
    do: {:ok, computed_type}

  defp verify_tuple(_, _), do: {:error, "Warning, file format and file extension do not match."}
end
