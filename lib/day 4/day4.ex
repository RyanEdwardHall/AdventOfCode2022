defmodule RangeWindow do
  @moduledoc """
  RangeWindow determines if two ranges overlap
  """
  def does_contain?(input) do
    [low_a, high_a, low_b, high_b] = Regex.scan(~r/\d+/, input) |> List.flatten()
    [low_a, high_a, low_b, high_b] = Enum.map([low_a, high_a, low_b, high_b], &String.to_integer(&1)) |> List.flatten
    cond do
        # Part A
        # low_a <= low_b && high_a >= high_b -> true
        # low_b <= low_a && high_b >= high_a -> true
        # Part B
        (low_a >= low_b) && (low_a <= high_b) -> true
        (low_b >= low_a) && (low_b <= high_a) -> true
        true -> false
    end
  end
end

File.stream!("input.txt")
|> Enum.map(&String.trim/1)
|> Enum.map(&RangeWindow.does_contain?/1)
|> Enum.count(&(&1 == true))
|> IO.puts 