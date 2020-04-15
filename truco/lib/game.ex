defmodule Truco.Game do
@moduledoc """
  This represents the hole game state
"""
defstruct n_players: nil, team_a: nil, team_b: nil, score_a: 0, score_b: 0, turn: nil
end
