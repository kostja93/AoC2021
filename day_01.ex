defmodule Aoc do
  def read_file(file_name) do
    {:ok, file_contents } = File.read(file_name)
    String.split(file_contents, "\n", trim: true)
  end

  def increase?([prev, curr]) do
    curr > prev
  end

  def increase?([prev]) do
    false
  end

  def task do
    read_file('input_day_01.txt')
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.chunk_every(2, 1)
    |> Enum.map(&Aoc.increase?/1)
    |> Enum.filter(fn x -> x == true end)
    |> Enum.count
  end

  def second_task do
    read_file('input_day_01.txt')
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.chunk_every(3, 1)
    |> Enum.filter(fn x -> Enum.count(x) == 3 end)
    |> Enum.map(fn x -> Enum.sum(x) end)
    |> Enum.chunk_every(2, 1)
    |> Enum.map(&Aoc.increase?/1)
    |> Enum.filter(fn x -> x == true end)
    |> Enum.count
  end
end
