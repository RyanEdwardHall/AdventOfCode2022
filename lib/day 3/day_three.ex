defmodule Dedupe do
  def score(letter) do
    numeric = letter |> String.to_charlist |> hd
    cond do
      String.upcase(letter) === letter -> numeric - 38
      true -> numeric - 96
    end
  end

  def findDup(coded_inventory) do
    length = String.length(coded_inventory)
    {inventory_a, inventory_b} = String.split_at(coded_inventory, div(length, 2))

    duplicate =
      MapSet.intersection(
        Enum.into(String.graphemes(inventory_a), MapSet.new()),
        Enum.into(String.graphemes(inventory_b), MapSet.new())
      )

    Dedupe.score(hd(MapSet.to_list(duplicate)))
  end
end

File.stream!("input.txt")
|> Enum.map(&String.trim/1)
|> Enum.map(&Dedupe.findDup/1)
|> Enum.sum()
|> IO.inspect
