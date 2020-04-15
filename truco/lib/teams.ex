defmodule Truco.Teams do
  @moduledoc """
  Handle and implements actions for teams such as
  change team turn, etc
  """
  alias Truco.Team
  alias Truco.Player
  alias Truco.Players

  @doc """
  Change the turn from one player to another, in the same team.

  ### Example
    iex> change_turn(%Team{turn: 1, players: [%Player{name: "p1"}, %Player{name: "p2"}]})
    %Team{turn: 2}
  """
  def change_turn(%Team{turn: turn, players: players} = team) do
    turn = case rem turn+1, (length(players)) do
            0 -> length(players)
            n -> n
          end
    %Team{team | turn: turn}
  end

  @doc """
  Update team hand_score
  """

  def update_handscore(%Team{hand_score: hs} = team) do
    %Team{team | hand_score: hs + 1}
  end

  @doc """
  Select a player to play a card by turn
  """
  def play_card_by_turn(%Team{players: players, turn: turn} = team) do
    # Search the player in team_a who has to play
    {id, player} = List.keyfind(players, turn, 0)
    player1 = Players.play_card(player)
    %Team{team | players: List.keyreplace(players, id, 0, {id, player1})}
  end

end
