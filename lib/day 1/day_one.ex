defmodule Parsing do
  def intParser(value) do
    case Integer.parse(value) do
      {num, ""} -> num
      _ -> nil
    end
  end
end

IO.inspect File.stream!("day_one_input.txt")
|> Enum.map(&String.trim/1)
|> Enum.map(&Parsing.intParser/1)
|> Enum.chunk_by(&is_number(&1))
|> Enum.filter(fn x -> x != [nil] end)
|> Enum.map(&Enum.sum/1)
|> Enum.sort(:desc)
