defmodule Truco do
  @moduledoc """
    Implements and handle a Truco Game
  """
  alias Truco.Deck
  # alias Truco.Card
  alias Truco.Player
  alias Truco.Players
  alias Truco.Game
  alias Truco.Team
  alias Truco.Teams

  @points2game 3

  @doc """
    Call this function to start the game
  """
  def main do
    IO.puts("Welcome!")

    name =
      IO.gets("Enter your name: ")
      |> String.trim()

    n_players = gets_number_in("How many players (2-4-6): ", [2, 4, 6])

    # All the machine players, starts with id 2
    players =
      Range.new(2, n_players)
      |> Enum.to_list()
      |> Enum.map(fn n -> %Player{name: "Player-#{n}"} end)

    # Append the client player and divide into 2 teams
    [players_a, players_b] =
      ([%Player{name: name, user?: true}] ++ players)
      |> Enum.chunk_every(div(n_players, 2))

    players_a = Enum.zip(Enum.to_list(Range.new(1, length players_a)), players_a)
    players_b = Enum.zip(Enum.to_list(Range.new(1, length players_b)), players_b)

    # Build the teams
    team_a = %Team{players: players_a, turn: 1}
    IO.puts(IO.ANSI.blue() <> "\nTeam A: ")
    Enum.each(players_a, fn {_,%Player{name: n}} -> IO.puts("-> #{n}") end)
    IO.puts(IO.ANSI.reset())

    team_b = %Team{players: players_b, turn: 1}
    IO.puts(IO.ANSI.red() <> "\nTeam B: ")
    Enum.each(players_b , fn {_,%Player{name: n}} -> IO.puts("-> #{n}") end)
    IO.puts(IO.ANSI.reset())

    turn = Enum.random([:team_a, :team_b])

    IO.puts("")
    %Game{n_players: n_players, team_a: team_a, team_b: team_b, turn: turn}
                          |> deal
                          |> play(n_players)
                          |> check_round()
                          |> check_hand()
                          |> check_game
    :ok
  end


  @spec deal(Truco.Game.t()) :: Truco.Game.t()
  defp deal(%Game{n_players: n, team_a: ta, team_b: tb}=game) do
    %Team{players: pa} = ta
    %Team{players: pb} = tb

    hands =
      Deck.create_deck()
      |> Deck.shuffle()
      |> Deck.deal()

    pa = set_cards(pa, Enum.take(hands, div(n, 2)))
    pb = set_cards(pb, Enum.take(Enum.drop(hands, div(n, 2)), div(n, 2)))

    %Game{game|team_a: %Team{ta | players: pa, hand_score: 0}, team_b: %Team{tb | players: pb, hand_score: 0}}
  end

  @spec play(Truco.Game.t(), non_neg_integer()) :: Truco.Game.t()
  defp play(game, 0) do
    game
  end
  defp play(%Game{turn: :team_a, team_a: ta} = game, rest) do

    ta = Teams.play_card_by_turn(ta)
    |> Teams.change_turn()

    %Game{game | team_a: ta, turn: :team_b}
    |> play(rest - 1)
  end
  defp play(%Game{turn: :team_b, team_b: tb} = game, rest) do

    tb = Teams.play_card_by_turn(tb)
    |> Teams.change_turn()

    %Game{game | team_b: tb, turn: :team_a}
    |> play(rest - 1)
  end

  defp check_round(%Game{team_a: ta, team_b: tb} = game) do
    %Team{players: pa, hand_score: handScoreA} = ta
    %Team{players: pb, hand_score: handScoreB} = tb
    {newA, newB} = cond do
      Players.lowest_truco_value(pa) < Players.lowest_truco_value(pb) ->
        IO.puts(IO.ANSI.blue() <> "Team A wins this round (#{handScoreA + 1} - #{handScoreB})\n" <> IO.ANSI.reset())
        {handScoreA + 1, handScoreB}
      Players.lowest_truco_value(pa) > Players.lowest_truco_value(pb) ->
        IO.puts(IO.ANSI.red() <> "Team B wins this round (#{handScoreA} - #{handScoreB + 1} )\n" <> IO.ANSI.reset())
        {handScoreA, handScoreB + 1}
      true ->
        IO.puts("Tie! (#{handScoreA} - #{handScoreB + 1} )\n")
        {handScoreA, handScoreB}
    end

    ta = %Team{ta | players: Enum.map(pa, fn {id, p} -> {id, Players.unselect_card p} end), hand_score: newA}
    tb = %Team{tb | players: Enum.map(pb, fn {id, p} -> {id, Players.unselect_card p} end), hand_score: newB}
    %Game{game | team_a: ta, team_b: tb}
  end

  defp check_hand(%Game{score_a: sa, score_b: sb, team_a: ta, team_b: tb} = game) do
    %Team{players: pa, hand_score: handScoreA} = ta
    %Team{players: pb, hand_score: handScoreB} = tb

    {deal?, newA, newB} = cond do
      handScoreA == 2 and handScoreB == 0 ->
        {true, sa + 1, sb}
      handScoreA == 0 and handScoreB == 2 ->
        {true, sa, sb + 1}
      Players.all_played?(pa) && Players.all_played?(pb) ->
        cond do
          handScoreA > handScoreB ->
            {true, sa + 1, sb}
          handScoreA < handScoreB ->
            {true, sa, sb + 1}
          true -> {true, sa, sb}
        end
      true ->
        {false, sa, sb}
    end

    case deal? do
      true -> IO.puts(IO.ANSI.cyan() <> "\n>>>> Team A: #{Integer.to_string(newA)} - Team B: #{Integer.to_string(newB)} <<<<\n" <> IO.ANSI.reset())
              %Game{game | score_a: newA, score_b: newB}
              |> deal()
      false -> %Game{game | score_a: newA, score_b: newB}
    end
    end


  defp check_game(%Game{score_a: sa, score_b: sb, team_a: ta, team_b: tb} = game) do

    cond do
      sa >= @points2game ->
        "Team A wins!"
      sb >= @points2game ->
        "Team B wins!"
      true ->
        repeat(game)
    end
  end

  defp repeat(%Game{n_players: n_players}=game) do
    game
    |> play(n_players)
    |> check_round()
    |> check_hand()
    |> check_game()
  end

  defp gets_number_in(promt, list) do
    str =
      IO.gets(promt)
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

  defp set_cards(players, cardss) do
    Enum.zip(players, cardss)
    |> Enum.map(fn {{id, player}, cards} -> {id, Players.receive_hand(player, cards)} end)
  end
end
