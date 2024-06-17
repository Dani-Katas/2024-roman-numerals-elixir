defmodule RomanNumerals do
  @roman_m %Roman{symbol: "M", value: 1000}
  @roman_d %Roman{symbol: "D", value: 500}
  @roman_c %Roman{symbol: "C", value: 100}
  @roman_l %Roman{symbol: "L", value: 50}
  @roman_x %Roman{symbol: "X", value: 10}
  @roman_v %Roman{symbol: "V", value: 5}
  @roman_i %Roman{symbol: "I", value: 1}
  @roman_none %Roman{symbol: "", value: 0}
  @romans [
    @roman_m,
    @roman_d,
    @roman_c,
    @roman_l,
    @roman_x,
    @roman_v,
    @roman_i,
    @roman_none
  ]

  def to_roman(number) do
    from_arabic(number) |> Enum.map(& &1.symbol) |> Enum.join()
  end

  defp from_arabic(number) do
    number |> from_arabic(@roman_m)
  end

  defp from_arabic(number, @roman_i) do
    @roman_i |> List.duplicate(number)
  end

  defp from_arabic(number, roman) when number >= roman.value do
    [roman | from_arabic(number - roman.value)]
  end

  defp from_arabic(number, roman) do
    subtractive_numeral = subtractive_pair(roman)
    subtract_value = roman.value - subtractive_numeral.value
    can_subtract = number >= subtract_value

    if can_subtract do
      [subtractive_numeral, roman | from_arabic(number - subtract_value)]
    else
      from_arabic(number, next(roman))
    end
  end

  defp next(roman) do
    index = Enum.find_index(@romans, &(&1 == roman))
    Enum.at(@romans, index + 1)
  end

  defp can_be_subtracted?(roman) do
    roman.value
    |> Integer.to_string()
    |> String.contains?("1")
  end

  defp subtractive_pair(roman) do
    @romans
    |> Enum.filter(&can_be_subtracted?/1)
    |> Enum.filter(&(&1.value < roman.value))
    |> List.first()
  end
end
