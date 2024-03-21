defmodule AsciiToSundaTest do
  use ExUnit.Case
  doctest AsciiToSunda

  test "parse vowel" do
    assert AsciiToSunda.parse("a") == "ᮃ"
    assert AsciiToSunda.parse("i") == "ᮄ"
    assert AsciiToSunda.parse("u") == "ᮅ"
    assert AsciiToSunda.parse("e") == "ᮈ"
    assert AsciiToSunda.parse("o") == "ᮇ"
  end

  test "parse consonant" do
    assert AsciiToSunda.parse("ha") == "ᮠ"
    assert AsciiToSunda.parse("na") == "ᮔ"
    assert AsciiToSunda.parse("ca") == "ᮎ"
    assert AsciiToSunda.parse("ra") == "ᮛ"
    assert AsciiToSunda.parse("ka") == "ᮊ"
  end

  test "parse multi consonant" do
    assert AsciiToSunda.parse("hanacaraka") == "ᮠᮔᮎᮛᮊ"
  end

  test "consonant and vowels" do
    assert AsciiToSunda.parse("ahanaaa") == "ᮃᮠᮔᮃᮃ"
  end

  test "parse consonant with rarangken" do
    assert AsciiToSunda.parse("bibu") == "ᮘᮤᮘᮥ"
  end

  test "rarangken extra" do
    assert AsciiToSunda.parse("bantal") == "ᮘᮔ᮪ᮒᮜ᮪"
  end

  test "raranken extra 2" do
    assert AsciiToSunda.parse("bandung") == "ᮘᮔ᮪ᮓᮥᮀ"
  end

  test "space" do
    assert AsciiToSunda.parse("smkn bandung") == "ᮞ᮪ᮙ᮪ᮊ᮪ᮔ᮪ ᮘᮔ᮪ᮓᮥᮀ"
  end

  test "capital" do
    assert AsciiToSunda.parse("SMKN bandung") == "ᮞ᮪ᮙ᮪ᮊ᮪ᮔ᮪ ᮘᮔ᮪ᮓᮥᮀ"
  end

  test "digit" do
    assert AsciiToSunda.parse("123") == "᮱᮲᮳"
  end

  test "digit with char" do
    assert AsciiToSunda.parse("SMKN 13 BANDUNG") == "ᮞ᮪ᮙ᮪ᮊ᮪ᮔ᮪ ᮱᮳ ᮘᮔ᮪ᮓᮥᮀ"
  end

  test "Hello World" do
    assert AsciiToSunda.parse("Hello World") == "ᮠᮨᮜᮣᮇ ᮝᮧᮁᮜ᮪ᮓ᮪"
  end
end
