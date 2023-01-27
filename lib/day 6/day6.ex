defmodule StreamLocator do
  @moduledoc """
  This locates the position in a stream where characters are unique for a range of 14
  """
  def locate(list, position, stream) do
    char = String.at(stream, position)
    new_list = [char | list]
    length = new_list |> Enum.uniq |> length
    cond do
      length >= 14 -> IO.puts(position + 1)
      length < 14 -> locate(Enum.take(new_list, 13), position + 1, stream)
    end
  end
end

{_, stream} = File.read("input.txt")
StreamLocator.locate(
    String.slice(stream, 0..12) |> String.graphemes,
    13,
    stream
)
