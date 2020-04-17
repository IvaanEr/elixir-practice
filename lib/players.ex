defmodule Truco.Players do
  @moduledoc """
  Handle and implements the actions of a player such as
  receive a hand, play a card, etc
  """
  alias Truco.Player

  @doc """
  Receive a hand of cards

  ### Example
    iex> Players.receive_hand(%Player{}, [%Card{}, %Card{}])
    %Player{cards: [%Card{}, %Card{}]}
  """
  def receive_hand(player, cards) do
    %Player{player | cards: cards}
  end

  @doc """
    Reset player selected card

    ### Example
    iex> Players.unselect_card(%Player{card_selected: %Card{name: "1 de Espada"} })
    %Player{card_selected: nil}
  """
  def unselect_card(player) do
    %Player{player | card_selected: nil}
  end


  @doc """
  Return true if all the players played all their cards,
  otherwise false.

  ### Example
    iex> Players.all_played?( [{1, %Player{cards: []}}, {2,%Player{cards: []}} ] )
    true

    iex> Players.all_played?( [{1, %Player{cards: [%Card{}]}}, {2,%Player{cards: []}} ] )
    false
  """
  def all_played?(players) do
    List.foldl(players, true, fn {_, player}, acum -> acum and player.cards == [] end)
  end

  @doc """
  Return the value of the lowest card this players had selected
  """
  @spec lowest_truco_value([Truco.Player.t()]) :: non_neg_integer()
  def lowest_truco_value(players) do
    List.foldl(players, 14, fn {_id, p}, min ->
      if p.card_selected.truco_value < min do
        p.card_selected.truco_value
      else
        min
      end
    end)
  end

  @doc """
  Play a card from the hand. If player.user? then select manually, else
  play the highest card.
  """
  def play_card(%Player{user?: true, name: name, cards: cards} = player) do
    IO.puts("Is your turn #{name}\n")

    Enum.zip(Enum.to_list(1..length(cards)), cards)
    |> Enum.each(fn {index, card} -> IO.puts(">>> #{card.name} (#{index})") end)

    card_number = gets_number_in("Select a card", Enum.to_list(Range.new(1, (length cards))))
    card_selected = Enum.at(cards, card_number - 1)
    IO.puts(IO.ANSI.green() <> "#{name} played >> #{card_selected.name} <<\n" <> IO.ANSI.reset())
    %Player{player | card_selected: card_selected, cards: List.delete(cards, card_selected)}
  end
  def play_card(%Player{user?: false, name: name, cards: cards} = player) do
    card_selected = Enum.min_by(cards, fn x -> x.num end)
    IO.puts(IO.ANSI.green() <> "#{name} played >> #{card_selected.name} <<\n" <> IO.ANSI.reset())
    %Player{player | card_selected: card_selected, cards: List.delete(cards, card_selected)}
  end


  defp gets_number_in(promt, list) do
    aux = Enum.map(list, &Integer.to_string/1) |> Enum.join(", ")
    str =
      IO.gets("#{promt} #{aux}: ")
      |> String.trim()

    case str do
      "" ->
        gets_number_in(promt, list)

      n ->
        if Enum.member?(list, String.to_integer(n)) do
          String.to_integer(n)
        else
          gets_number_in(promt, list)
        end
    end
  end



end
