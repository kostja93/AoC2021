defmodule Aoc do
  def puzzle_input do
    {:ok, file_contents } = File.read("input_day_03.txt")
    String.split(file_contents, "\n", trim: true)
    |> Enum.map(fn x -> String.split(x, "", trim: true) 
    |> Enum.map(fn y -> String.to_integer(y) end) end)
    |> Enum.map(fn x -> List.to_tuple(x) end)
  end

  def bit_count do
    tuple_size Enum.at(puzzle_input, 0)
  end

  def btoa(bits) do
    bits_count = tuple_size(bits) - 1
    Enum.reduce(bits_count..0, 0, fn i, acc -> 
      elem(bits, bits_count - i) * :math.pow(2, i) + acc 
    end)
  end

  def count(values, pos) do
    Enum.reduce(values, 0, fn penta, acc ->
      if elem(penta, pos) == 1 do
        acc + 1
      else
        acc
      end
    end)
  end

  def gamma(values) do
    most_common = div(Enum.count(values), 2)
    size = tuple_size(Enum.at(values, 0)) - 1
    Enum.map(0..(size), fn(pos) -> 
      if count(values, pos) > most_common do
        1
      else
        0
      end
    end)
    |> List.to_tuple
  end

  def epsilon(values) do
    gamma(values)
    |> Tuple.to_list
    |> Enum.map(fn
      1 -> 0
      0 -> 1
    end)
    |> List.to_tuple
  end

  def task do
    input = puzzle_input()
    btoa(gamma(input)) * btoa(epsilon(input))
  end

  def find_most_common(values, pos) do
    mapped_list = Enum.map(values, fn x -> elem(x, pos) end)
    zero_count = Enum.filter(mapped_list, fn x -> x == 0 end) |> Enum.count
    ones_count = Enum.filter(mapped_list, fn x -> x == 1 end) |> Enum.count

    cond do
      zero_count > ones_count -> 0
      zero_count < ones_count -> 1
      zero_count == ones_count -> 1
    end
  end

  def filter_most([ last_element ], _pos) do
    last_element
  end

  def filter_most(values, pos) do
    most_common = find_most_common(values, pos)
    Enum.filter(values, fn x -> elem(x, pos) == most_common end)
    |> filter_most(pos + 1)
  end

  def find_least_common(values, pos) do
    mapped_list = Enum.map(values, fn x -> elem(x, pos) end)
    zero_count = Enum.filter(mapped_list, fn x -> x == 0 end) |> Enum.count
    ones_count = Enum.filter(mapped_list, fn x -> x == 1 end) |> Enum.count

    cond do
      zero_count < ones_count -> 0
      zero_count > ones_count -> 1
      zero_count == ones_count -> 0
    end
  end

  def filter_least([ last_element ], _pos) do
    last_element
  end

  def filter_least(values, pos) do
    common = find_least_common(values, pos)
    Enum.filter(values, fn x -> elem(x, pos) == common end)
    |> filter_least(pos + 1)
  end

  def task2 do
    btoa(filter_most(puzzle_input, 0))
    *
    btoa(filter_least(puzzle_input, 0))
  end
end
