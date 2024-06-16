defmodule RomanNumeralsTest do
  use ExUnit.Case
  doctest RomanNumerals

  @parameters "./romans.csv"
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> Stream.drop(1)
    |> Stream.map(&String.trim(&1, "\n"))
    |> Stream.map(&String.split(&1, ","))
    |> Stream.map(fn ([arabic, roman]) -> {arabic |> String.to_integer, roman} end)
    |> Enum.to_list

  # for {input, expected} <- @parameters do
  #   test "from_arabic(#{input}) == #{expected}" do
  #     assert RomanValue.from_arabic_to_roman_string(unquote(input)) == unquote(expected)
  #   end
  # end

  test "it works" do
    for {input, expected} <- @parameters do
      assert RomanNumerals.from_arabic_to_roman_string(input) == expected
    end
  end
end
