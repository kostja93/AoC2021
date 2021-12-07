defmodule Aoc do
  def input do
    {:ok, file_contents } = File.read("input_test_06.txt")
    [file_contents | rest] = String.split(file_contents, "\n")
    String.split(file_contents, ",", trim: true)
    |> Enum.map(fn x -> String.to_integer(x) end)
  end

  def generate(0) do
    [6, 8]
  end

  def generate(timer) do
    [timer - 1]
  end

  def round(values, 0) do
    values
  end

  def round(values, day) do
    Enum.flat_map(values, &Aoc.generate/1)
    |> round(day - 1)
  end
end
