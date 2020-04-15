# Truco

Simple Truco!

It only represents the card game, without Truco or Envido.
Your team mates and enemies always play the highest card.

## Flow
At a high level of abstraction the flow can be summarized in the following steps

```
main() -> deal() -> play() -> check_round() -> check_hand() -> check_game()  -> [deal() | :ok]

where
  deal() deals the cards to the players
  play() make every player select one card
  check_round() check which team won the round of cards
  check_hand() if the hand is over, check which team won the hand
  check_game() check if the game is over (a game is over when a team reach 3 points)
```
```
 +------+
 | main |
 +--+---+
    |
    |
    v
 +--+---+
 | deal |<----------+
 +--+---+           |
    |               |
    |               |
    |               |
 +--+---+           |
 |play  |           |
 +---+--+           |
     |              |
     |              |
+----v--------+     |
| check_round |     |
|             |     |
+---+---------+     |
    |               |
    |               |
+---v--------+      |
| check_hand |      |
+----+-------+      |
    |               |
    |               |
+----v---------+    | 
| check_game   |+---+
+--------------+
```

## Play
Start the game.
After enter your name and select the number of players the game starts.
```
  iex> Truco.main
  Welcome!
  Enter your name: Jhon
  How many players (2-4-6): 4
```