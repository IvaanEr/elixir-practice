defmodule Truco.Deck do
  alias Truco.Card

  def create_deck do
    values = [1, 2, 3, 4, 5, 6, 7, 10, 11, 12]
    suits = ["Espada", "Copa", "Oro", "Basto"]
    map = truco_magic()
    for v <- values, s <- suits do
      %Card{name: "#{v} de #{s}", palo: s, num: v, truco_value: Map.get(map, "#{v} de #{s}")}
    end
  end

  def shuffle(deck) do
    deck
    |> Enum.shuffle()
  end

  def deal(deck) do
      deck
      |> Enum.chunk_every(3)
  end


  def truco_magic do
    %{
      "1 de Espada" => 1,
      "1 de Basto" => 2,
      "7 de Espada" => 3,
      "7 de Oro" => 4,
      "3 de Espada" => 5,
      "3 de Oro" => 5,
      "3 de Basto" => 5,
      "3 de Copa" => 5,
      "2 de Espada" => 6,
      "2 de Oro" => 6,
      "2 de Basto" => 6,
      "2 de Copa" => 6,
      "1 de Oro" => 7,
      "1 de Copa" => 7,
      "12 de Espada" => 8,
      "12 de Oro" => 8,
      "12 de Basto" => 8,
      "12 de Copa" => 8,
      "11 de Espada" => 9,
      "11 de Oro" => 9,
      "11 de Basto" => 9,
      "11 de Copa" => 9,
      "10 de Espada" => 10,
      "10 de Oro" => 10,
      "10 de Basto" => 10,
      "10 de Copa" => 10,
      "7 de Copa" => 11,
      "7 de Basto" => 11,
      "6 de Espada" => 12,
      "6 de Oro" => 12,
      "6 de Basto" => 12,
      "6 de Copa" => 12,
      "5 de Espada" => 13,
      "5 de Oro" => 13,
      "5 de Basto" => 13,
      "5 de Copa" => 13,
      "4 de Espada" => 14,
      "4 de Oro" => 14,
      "4 de Basto" => 14,
      "4 de Copa" => 14
    }
  end
end
