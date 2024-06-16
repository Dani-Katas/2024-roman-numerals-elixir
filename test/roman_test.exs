defmodule RomanTest do
  use ExUnit.Case, async: true
  doctest Roman

  @parameters "./romans.csv"
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> Stream.drop(1)
    |> Stream.map(&String.trim(&1, "\n"))
    |> Stream.map(&String.split(&1, ","))
    |> Stream.map(fn ([arabic, roman]) -> {arabic |> String.to_integer, roman} end)
    |> Enum.to_list

  for {input, expected} <- @parameters do
    test "from_arabic(#{input}) == #{expected}" do
      assert RomanValue.from_arabic(unquote(input)) == unquote(expected)
    end
  end

  #test "four" do
  #  assert RomanValue.from_arabic(4) == "IV"
  #end
end
