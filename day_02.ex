defmodule Task1 do
  def to_vector(["forward", value]) do
    { String.to_integer(value), 0 }
  end

  def to_vector(["down", value]) do
    { 0, String.to_integer(value) }
  end

  def to_vector(["up", value]) do
    { 0, String.to_integer(value) * -1 }
  end

  def sum({ horizontal, vertical }, { sum_h, sum_v}) do
    { horizontal + sum_h, vertical + sum_v }
  end

  def product({ horizontal, vertical }) do
    horizontal * vertical
  end
end

defmodule Task2 do
  def sum({ 0, depth }, { sum_h, sum_d, aim}) do
    { sum_h, sum_d, aim + depth }
  end

  def sum({ horizontal, 0 }, { sum_h, sum_d, aim}) do
    { horizontal + sum_h, sum_d + horizontal * aim, aim }
  end

  def product({ horizontal, vertical, _aim }) do
    horizontal * vertical
  end
end

defmodule Aoc do
  def read_file(file_name) do
    {:ok, file_contents } = File.read(file_name)
    String.split(file_contents, "\n", trim: true)
    |> Enum.map(fn command -> String.split(command, " ") end)
  end

  def task do
    read_file('input_day_02.txt')
    |> Enum.map(&Task1.to_vector/1)
    |> Enum.reduce(&Task1.sum/2)
    |> Task1.product
  end

  def task2 do
    read_file('input_day_02.txt')
    |> Enum.map(&Task1.to_vector/1)
    |> Enum.reduce({0, 0, 0}, &Task2.sum/2)
    |> Task2.product
  end
end
