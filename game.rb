require_relative "lib/board.rb"

game_board = Board.new()

def game_round ()
    # nil -> nil
    # Plays a round of tictactoe between two players
    cross_win = false
    circle_win = false
    turn_player = 1
    puts "Player 1 is \"X\"s"
    puts "Player 2 is \"O\"s"
    until cross_win || circle_win
        puts "Player#{turn_player} turn"
        puts "Select a row:"
        row_number = gets
        puts "Select a column:"


        # Change turn player
        if turn_player = 1
            turn_player = 2
        else
            turn_player = 1
        end
        
    end
end