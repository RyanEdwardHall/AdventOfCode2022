# The important lesson i learned: 
# Enum.Reduce returns the altered array in the accumulator. 
# Enum.each returns :ok. 
# You almost always want reduce!

defmodule Container do
    def fetch_instructions(input) do
        raw_input = Regex.scan(~r/\d+/, input) |> List.flatten
        [move, from, to] = Enum.map(raw_input, &String.to_integer(&1))
        %{move: move, from: from, to: to}
    end
    def move(containers, i) do
        # Part 2
        containers = Map.replace(containers, i.to, Enum.slice(containers[i.from], 0..i.move - 1) ++ containers[i.to])
        Map.replace(containers, i.from, Enum.drop(containers[i.from], i.move))
        # Part 1
        # Enum.reduce(1..i.move, containers, fn (_, containers) -> 
        #     [head | tail] = containers[i.from]
        #     containers = Map.replace(containers, i.from, tail)
        #     containers = Map.replace(containers, i.to, [head|containers[i.to]])
        # end)

    end
end

containers = %{
    1 => ["P", "D", "Q", "R", "V", "B", "H", "F"],
    2 => ["V", "W", "Q", "Z", "D", "L"],
    3 => ["C", "P", "R", "G", "Q", "Z", "L", "H"],
    4 => ["B", "V", "J", "F", "H", "D", "R"],
    5 => ["C", "L", "W", "Z"],
    6 => ["M", "V", "G", "T", "N", "P", "R", "J"],
    7 => ["S", "B", "M", "V", "L", "R", "J"],
    8 => ["J", "P", "D"],
    9 => ["V", "W", "N", "C", "D"],
}

File.stream!("input.txt")
|> Enum.map(&String.trim/1)
|> Enum.map(&Container.fetch_instructions/1)
|> Enum.reduce(containers, fn (i, acc) -> Container.move(acc, i) end)
|> IO.inspect

