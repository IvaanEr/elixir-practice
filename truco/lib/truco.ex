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
    Call this function to start the game.
    It ask your name and starts the game
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
    players_b = Enum.zip(Enum.to_list(Range.new(1, length players_a)), players_b)

    # Build the teams
    team_a = %Team{players: players_a, turn: 1}
    team_b = %Team{players: players_b, turn: 1}

    turn = Enum.random([:team_a, :team_b])

    %Game{n_players: n_players, team_a: team_a, team_b: team_b, turn: turn}
                          |> deal
                          |> play(n_players)
                          |> check_round
                          # |> IO.inspect
                          |> check_hand
                          # |> check_game
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

    %Game{game|team_a: %Team{ta | players: pa}, team_b: %Team{tb | players: pb}}
  end

  @spec play(Truco.Game.t(), non_neg_integer()) :: Truco.Game.t()
  def play(game, 0) do
    IO.inspect(game)
    game
  end
  def play(%Game{turn: :team_a, team_a: ta} = game, rest) do
    IO.inspect("turno team_a")
    ta = Teams.play_card_by_turn(ta)
    %Game{game | team_a: ta, turn: :team_b}
    |> play(rest - 1)
  end
  def play(%Game{turn: :team_b, team_b: tb} = game, rest) do
    IO.inspect("turno team_b")

    tb = Teams.play_card_by_turn(tb)
    |> Teams.change_turn()

    %Game{game | team_a: tb, turn: :team_a}
    |> play(rest - 1)
  end

  def check_round(%Game{team_a: ta, team_b: tb} = game) do
    %Team{players: pa, hand_score: handScoreA} = ta
    %Team{players: pb, hand_score: handScoreB} = tb
    {newA, newB} = cond do
      Players.lowest_truco_value(pa) < Players.lowest_truco_value(pb) ->
        {handScoreA + 1, handScoreB}
      Players.lowest_truco_value(pa) > Players.lowest_truco_value(pb) ->
        {handScoreA, handScoreB + 1}
      true -> {handScoreA, handScoreB}
    end
    ta = %Team{ta | hand_score: newA}
    tb = %Team{tb | hand_score: newB}
    %Game{game | team_a: ta, team_b: tb}
  end

  def check_hand(%Game{score_a: sa, score_b: sb, team_a: ta, team_b: tb} = game) do
    %Team{players: pa, hand_score: handScoreA} = ta
    %Team{players: pb, hand_score: handScoreB} = tb

    {newA, newB} = cond do
      handScoreA == 2 and handScoreB == 0 ->
        {sa + 1, sb}
      handScoreA == 0 and handScoreB == 2 ->
        {sa, sb + 1}
      Players.all_played?(pa) && Players.all_played?(pb) ->
        cond do
          handScoreA > handScoreB ->
            {sa + 1, sb}
          handScoreA < handScoreB ->
            {sa, sb + 1}
          true -> {sa, sb}
        end
      true ->
        {sa, sb}
    end
    %Game{game| score_a: newA, score_b: newB}
    end

  #   case status do
  #     :finish ->
  #       newPlayersA = Enum.map(pa, fn {id, p} -> {id, Players.unselect_card(p)
  #                                                 |> Players.reset_hand} end)
  #       newPlayersB = Enum.map(pa, fn {id, p} -> {id, Players.unselect_card(p)
  #                                                 |> Players.reset_hand} end)
  #       ta = %Team{ta | players: newPlayersA, hand_score: newHandScoreA}
  #       tb = %Team{tb | players: newPlayersB, hand_score: newHandScoreB}
  #       %Game{game | team_a: ta, team_b: tb}
  #     :continue ->
  #       IO.inspect("Continue!")
  #       ta = %Team{ta | hand_score: newHandScoreA}
  #       tb = %Team{tb | hand_score: newHandScoreB}
  #       %Game{game | team_a: ta, team_b: tb}
  #   end
  # end

  def do_check_hand(%Game{team_a: ta, team_b: tb}) do
    %Team{players: pa, hand_score: handScoreA} = ta
    %Team{players: pb, hand_score: handScoreB} = tb
    cond do
      Players.lowest_truco_value(pa) < Players.lowest_truco_value(pb) ->
        {:finish, handScoreA + 1, handScoreB}
      Players.lowest_truco_value(pa) > Players.lowest_truco_value(pb) ->
        {:finish, handScoreA, handScoreB + 1}
      true -> {:finish, handScoreA, handScoreB}
    end
  end

  def check_game(%Game{} = game) do
    {:continue, game}
  end



  @doc """
    Implements IO.gets with `promt` until the value is member of the `list`
  """
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

  @doc """
  Set cards for all the players.
  """
  defp set_cards(players, cardss) do
    Enum.zip(players, cardss)
    |> Enum.map(fn {{id, player}, cards} -> {id, Players.receive_hand(player, cards)} end)
  end


end
