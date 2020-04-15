defmodule TeamsTest do
  use ExUnit.Case
  alias Truco.Team
  alias Truco.Player
  alias Truco.Teams

  doctest(Truco.Teams)

  test "Team change turn" do
    %Team{turn: newTurn} = Teams.change_turn(%Team{turn: 1, players: [%Player{name: "p1"}, %Player{name: "p2"}]})
    assert newTurn == 2
  end

  test "Team change turn 2" do
    %Team{turn: newTurn} = Teams.change_turn(%Team{turn: 2, players: [%Player{name: "p1"}, %Player{name: "p2"}]})
    assert newTurn == 1
  end

end
