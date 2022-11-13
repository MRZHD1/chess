
# Ruby Chess

This is a Ruby Chess game built to be played from the CLI. It comes with the stockfish engine, thanks to this [ruby wrapper](https://github.com/linrock/ruby-stockfish).

This game comes with your standard suite of chess rules, such as en passant, castling, and can figure out checks and checkmates. It only allows legal chess moves and you have the ability to fight Stockfish 6.




## Executing the files

This game is has a live preview on repl.it! Check it [here](https://replit.com/@MRZHD1/chess?v=1).

If you otherwise want to run it on your system, download the files, and follow the steps below. You need to have Ruby and the bundler gem.

### Installation
Once you have the files downloaded, open a terminal in the root directory and type in:

```bash
  bundle install
```

If you already have stockfish installed, or just installed it, run the following command.
 
```bash
  bundle exec ruby ./lib/main.rb
```

The game should pop up now!


## Usage

Once you run main.rb, you will be prompted to either start a new game or load a game. If there is no games in the saved_games.txt, it'll start a new game anyways. So click `Enter` to start.

After that, you'll be prompted to either start a 2-player game, or fight against Stockfish. If you want to fight Stockfish, type `1`. Otherwise click `Enter`.

The rest is simple, type in the square you're moving from,  and the square you're moving to, in one line with no spaces or capitals. Type in 'save' at anytime to save the game, and 'quit' at anytime to stop the game.
## Demo

![demo](https://i.imgur.com/QOpwYeS.gif)

