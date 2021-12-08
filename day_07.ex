defmodule Aoc do
  def input do
    { :ok, file_contents } = File.read("input_day_07.txt")
    [ file_contents, _ ] = String.split(file_contents, "\n")
    String.split(file_contents, ",")
    |> Enum.map(fn x -> String.to_integer(x) end)
  end

  def fuel(val) do
    Enum.sum(0..abs(val))
  end

  def task do
    min = Enum.min(input)
    max = Enum.max(input)

    Enum.map(min..max, fn x ->
      Enum.map(input, fn pos -> fuel(x - pos) end)
      |> Enum.sum
    end)
    |> Enum.min
  end
end
