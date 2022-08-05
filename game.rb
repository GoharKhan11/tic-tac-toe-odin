require_relative "lib/board.rb"

class Game

    def initialize ()
        @game_board = Board.new()
    end

    def game_round ()
        # nil -> nil
        # Plays a round of tictactoe between two players

        # Checks if a player has won
        game_won = false
        # Stores the player whose turn it is (1 for player1 and 2 for player2)
        turn_player = 1
        # Storees the turns number the round is on
        turn_number = 0
        # Stores the symbol used for the player
        player_symbol = "X"

        # Indicate which player is which symbol
        puts "Player 1 is \"X\"s"
        puts "Player 2 is \"O\"s"

        # Continue game loop till someone wins or 9 rounds pass (no more spaces on the board)
        until game_won || turn_number >= 9

            # Indicate whose turn it is
            puts "Player#{turn_player}'s turn"
            # Get a row number
            puts "Select a row:"
            row_number = (gets.to_i - 1)
            # Get a column number
            puts "Select a column:"
            column_number = (gets.to_i - 1)

            # Insert symbol for turn player into the desires grid area
            is_empty = @game_board.set_empty_value(row_number, column_number, player_symbol)

            while is_empty == false do
                puts "That space is already taken, please select a different space"
                # Get a row number
                puts "Select a row:"
                row_number = (gets.to_i - 1)
                # Get a column number
                puts "Select a column:"
                column_number = (gets.to_i - 1)

                # Insert symbol for turn player into the desires grid area
                is_empty = @game_board.set_empty_value(row_number, column_number, player_symbol)
            end

            # Shows current board state
            puts @game_board.show_board()

            game_won = check_win(player_symbol)

            # Change turn player and symbol
            if turn_player == 1 && game_won == false
                turn_player = 2
                player_symbol = "O"
            elsif turn_player == 2 && game_won == false
                turn_player = 1
                player_symbol = "X"
            end

            turn_number += 1
        end

        if game_won
            puts "Player#{turn_player} Wins!"
        else
            puts "The game is a draw."
        end

    end

    def check_win(symbol)
        result = @game_board.check_rows(symbol)
        result = @game_board.check_columns(symbol) if result == false
        result = @game_board.check_diagonals(symbol) if result == false
        result
    end
end

main_game = Game.new()

main_game.game_round()