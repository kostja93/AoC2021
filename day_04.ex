defmodule Aoc do
  def drawn_numbers do
    {:ok, file_contents } = File.read("input_day_04.txt")
    String.split(file_contents, "\n", trim: true)
    |> Enum.at(0)
    |> String.split(",", trim: true)
    |> Enum.map(fn x -> String.to_integer(x) end)
  end

  def boards do
    {:ok, file_contents } = File.read("input_day_04.txt")
    [_numbers | boards] = String.split(file_contents, "\n", trim: true)
    Enum.map(boards, fn x -> String.split(x, " ", trim: true) 
    |> Enum.map(fn y -> %{ number: String.to_integer(y), marked: false } end) end)
    |> Enum.chunk_every(5)
  end

  def mark_fields(board, field) do
    Enum.map(board, fn row ->
      Enum.map(row, fn fld ->
        if fld.number == field do
          %{ number: fld.number, marked: true }
        else
          fld
        end
      end)
    end)
  end

  def has_complete_row(board) do
    Enum.reduce(board, false, fn row, acc ->
      acc || Enum.reduce(row, true, fn fld, akk ->
        akk && fld.marked
      end)
    end)
  end

  def has_complete_column(board) do
    Enum.reduce(0..4, false, fn i, acc ->
      acc || Enum.reduce(board, true, fn row, akk ->
        akk && Enum.at(row, i).marked
      end)
    end)
  end

  def round([ finished_board ], _i) do
    finished_board
  end

  def round(boards, i) do
    drawn_number = Enum.at(drawn_numbers(), i)
    new_boards = Enum.map(boards, fn board -> mark_fields(board, drawn_number) end)
    winning_boards = Enum.filter(new_boards, fn board -> has_complete_column(board) || has_complete_row(board) end)

    if winning_boards == [] do
      round(new_boards, i + 1)
    else
      %{ board: Enum.at(winning_boards, 0), number: drawn_number }
    end
  end

  def value(board) do
    Enum.reduce(board, 0, fn row, acc ->
      acc + Enum.reduce(row, 0, fn fld, akk -> if !fld.marked, do: akk + fld.number, else: akk end)
    end)
  end

  def task do
    %{ board: board, number: number } = round(boards, 0)
    number * value(board)
  end
end
