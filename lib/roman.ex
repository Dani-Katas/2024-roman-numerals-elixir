defmodule Roman do
  defstruct symbol: "", value: 0
end

defmodule RomanValue do
  @roman_m %Roman{symbol: "M", value: 1000}
  @roman_d %Roman{symbol: "D", value: 500}
  @roman_c %Roman{symbol: "C", value: 100}
  @roman_l %Roman{symbol: "L", value: 50}
  @roman_x %Roman{symbol: "X", value: 10}
  @roman_v %Roman{symbol: "V", value: 5}
  @roman_i %Roman{symbol: "I", value: 1}
  @roman_none %Roman{symbol: "", value: 0}

  defp get_next(@roman_m), do: @roman_d
  defp get_next(@roman_d), do: @roman_c
  defp get_next(@roman_c), do: @roman_l
  defp get_next(@roman_l), do: @roman_x
  defp get_next(@roman_x), do: @roman_v
  defp get_next(@roman_v), do: @roman_i
  defp get_next(@roman_i), do: @roman_none

  defp get_restable(@roman_m), do: @roman_c
  defp get_restable(@roman_d), do: @roman_c
  defp get_restable(@roman_c), do: @roman_x
  defp get_restable(@roman_l), do: @roman_x
  defp get_restable(@roman_x), do: @roman_i
  defp get_restable(@roman_v), do: @roman_i
  defp get_restable(@roman_i), do: @roman_none

  def from_arabic_to_roman_string(number) do
    from_arabic(number) |> Enum.map(fn r -> r.symbol end) |> Enum.join()
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
    restable = get_restable(roman)
    should_have_previous_unit = number >= (roman.value - restable.value)

    if should_have_previous_unit do
      [restable, roman | from_arabic(number - (roman.value - restable.value))]
    else
      from_arabic(number, get_next(roman))
    end
  end
end
