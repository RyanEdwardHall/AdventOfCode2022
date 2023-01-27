defmodule Dedupe do
  def score(letter) do
    numeric = letter |> String.to_charlist |> hd
    if String.upcase(letter) === letter, do: numeric - 38, else: numeric - 96
  end

  def find_dup(coded_inventory) do
    [a, b, c] = coded_inventory

    duplicate =
      MapSet.intersection(
        Enum.into(String.graphemes(a), MapSet.new()),
        Enum.into(String.graphemes(b), MapSet.new())
      )
    duplicate = 
      MapSet.intersection(
        duplicate,
        Enum.into(String.graphemes(c), MapSet.new())
      )
    score(hd(MapSet.to_list(duplicate)))
  end
end

File.stream!("input.txt")
  |> Stream.map(&String.trim/1)
  |> Stream.chunk_every(3)
  |> Stream.map(&Dedupe.find_dup/1)
  |> Enum.sum()
  |> IO.puts