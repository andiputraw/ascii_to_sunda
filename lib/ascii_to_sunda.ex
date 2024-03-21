defmodule AsciiToSunda do
  @moduledoc """
  Documentation for `AsciiToSunda`.

  this module will parse ascii character to sundaneese script.

  """

  @doc """
  Hello world.

  ## Examples

      iex> AsciiToSunda.parse("bandung")
      "ᮘᮔ᮪ᮓᮥᮀ"

  """
  @vowel ["a", "i", "u", "e", "o"]
  @consonant [
    "k",
    "g",
    "n",
    "c",
    "j",
    "t",
    "d",
    "n",
    "p",
    "b",
    "m",
    "y",
    "r",
    "l",
    "w",
    "s",
    "h",
    "f",
    "q",
    "v",
    "x",
    "z"
  ]

  @rarangken ["a", "i", "u", "e", "o", "r", "l", "y"]
  @raranken_extra ["r", "h"]
  @space [" ", "\n", "\t"]
  @digit ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

  defmacro is_vowel(x) do
    quote do
      unquote(x) in @vowel
    end
  end

  defmacro is_consonant(x) do
    quote do
      unquote(x) in @consonant
    end
  end

  defmacro is_consonant_with_rarangken_extra(x1, x2, x3) do
    quote do
      unquote(x1) in @consonant and unquote(x2) in @rarangken and
        unquote(x3) in @raranken_extra
    end
  end

  defmacro is_space(x) do
    quote do
      unquote(x) in @space
    end
  end

  defmacro is_consonant_with_rarangken_in_middle_and_consonant_last(x1, x2, x3, x4) do
    quote do
      unquote(x1) in @consonant and unquote(x2) in @rarangken and
        unquote(x3) in @raranken_extra and unquote(x4) in @consonant
    end
  end

  defmacro is_consonant_with_rarangken_and_ng(x1, x2, x3, x4) do
    quote do
      unquote(x1) in @consonant and unquote(x2) in @rarangken and unquote(x3) == "n" and
        unquote(x4) == "g"
    end
  end

  defmacro is_consonant_with_rarangken(x1, x2) do
    quote do
      unquote(x1) in @consonant and unquote(x2) in @rarangken
    end
  end

  defmacro is_both_consonant(x1, x2) do
    quote do
      unquote(x1) in @consonant and unquote(x2) in @consonant
    end
  end

  defmacro is_digit(x) do
    quote do
      unquote(x) in @digit
    end
  end

  @spec parse(String.t()) :: String.t()
  def parse(string) do
    string |> String.downcase() |> String.graphemes() |> _parse([]) |> Enum.join()
  end

  @spec _parse(list(), any()) :: any()
  def _parse(pre, acc) do
    case pre do
      [] ->
        acc

      [x] when is_vowel(x) ->
        [acc | [vowel_to_sunda(x)]]

      [x] when is_consonant(x) ->
        [acc | [consonant_to_sunda(x), "᮪"]]

      [x] when is_digit(x) ->
        [acc | [digit_to_sunda(x)]]

      [x1, x2, x3]
      when is_consonant_with_rarangken_extra(x1, x2, x3) ->
        [
          acc | [consonant_to_sunda(x1), rarangken_to_sunda(x2), rarangken_to_sunda_extra(x3)]
        ]

      [x1, x2] when is_both_consonant(x1, x2) ->
        [
          acc | [consonant_to_sunda(x1), "᮪", consonant_to_sunda(x2), "᮪"]
        ]

      [x | s] when is_space(x) ->
        _parse(s, [acc | [x]])

      [x | s] when is_vowel(x) ->
        _parse(s, [acc | [vowel_to_sunda(x)]])

      [x | s] when is_digit(x) ->
        _parse(s, [acc | [digit_to_sunda(x)]])

      [x1, x2, x3, x4 | s]
      when is_consonant_with_rarangken_in_middle_and_consonant_last(x1, x2, x3, x4) ->
        _parse([x4 | s], [
          acc | [consonant_to_sunda(x1), rarangken_to_sunda(x2), rarangken_to_sunda_extra(x3)]
        ])

      [x1, x2, x3, x4 | s]
      when is_consonant_with_rarangken_and_ng(x1, x2, x3, x4) ->
        _parse(s, [
          acc
          | [consonant_to_sunda(x1), rarangken_to_sunda(x2), rarangken_to_sunda_extra_2("n", "g")]
        ])

      [x1, x2 | s] when is_consonant_with_rarangken(x1, x2) ->
        _parse(s, [acc | [consonant_to_sunda(x1), rarangken_to_sunda(x2)]])

      [x1, x2 | s] when is_both_consonant(x1, x2) or (is_consonant(x1) and is_space(x2)) ->
        _parse([x2 | s], [acc | [consonant_to_sunda(x1), "᮪"]])
    end
  end

  defp vowel_to_sunda(char) do
    case char do
      "a" -> "ᮃ"
      "i" -> "ᮄ"
      "u" -> "ᮅ"
      "e" -> "ᮈ"
      "o" -> "ᮇ"
    end
  end

  defp consonant_to_sunda(char) do
    case char do
      "k" -> "ᮊ"
      "g" -> "ᮌ"
      "q" -> "ᮋ"
      "c" -> "ᮎ"
      "j" -> "ᮏ"
      "z" -> "ᮐ"
      "t" -> "ᮒ"
      "d" -> "ᮓ"
      "n" -> "ᮔ"
      "p" -> "ᮕ"
      "f" -> "ᮖ"
      "v" -> "ᮗ"
      "b" -> "ᮘ"
      "m" -> "ᮙ"
      "y" -> "ᮚ"
      "r" -> "ᮛ"
      "l" -> "ᮜ"
      "w" -> "ᮝ"
      "s" -> "ᮞ"
      "x" -> "ᮟ"
      "h" -> "ᮠ"
    end
  end

  defp rarangken_to_sunda(rarangken) do
    case rarangken do
      "i" -> "ᮤ"
      "o" -> "ᮧ"
      "u" -> "ᮥ"
      "e" -> "ᮨ"
      "r" -> "ᮢ"
      "l" -> "ᮣ"
      "y" -> "ᮡ"
      "a" -> ""
    end
  end

  defp rarangken_to_sunda_extra(extra) do
    case extra do
      "r" -> "ᮁ"
      "h" -> "ᮂ"
    end
  end

  defp rarangken_to_sunda_extra_2(extra1, extra2) do
    case [extra1, extra2] do
      ["n", "g"] -> "ᮀ"
    end
  end

  defp digit_to_sunda(digit) do
    case digit do
      "0" -> "᮰"
      "1" -> "᮱"
      "2" -> "᮲"
      "3" -> "᮳"
      "4" -> "᮴"
      "5" -> "᮵"
      "6" -> "᮶"
      "7" -> "᮷"
      "8" -> "᮸"
      "9" -> "᮹"
    end
  end
end
