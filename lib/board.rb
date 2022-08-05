require_relative "node-list.rb"

class Board

    def initialize ()
        @board_grid = Grid.new(3, 3, " ")
    end

    def check_rows (symbol)
        # str -> bool
        # Check if any row is 3 matching desired symbols

        # Create array of symbols
        check_array = Array.new(3, symbol)
        # Counter to move through the rows
        counter = 0
        # Bool to check if match found
        match = false
        # Checks each row till a match is found
        until match == true || counter >= 3 do
            match = true if check_array == @board_grid.get_row_array(counter)
            # Move to next row
            counter += 1
        end
        match
    end

    def check_columns (symbol)
        # str -> bool
        # Check if any column is 3 matching desired symbols

        # Create array of symbols
        check_array = Array.new(3, symbol)
        # Counter to move through the columns
        counter = 0
        # Bool to check if match found
        match = false
        # Checks each column till a match is found
        until match == true || counter >= 3 do
            match = true if check_array == @board_grid.get_column_array(counter)
            # Move to next columns
            counter += 1
        end
        match
    end

    def check_diagonals (symbol)
        # str -> bool
        # Check if any column is 3 matching desired symbols

        # Create array of symbols
        check_array = Array.new(3, symbol)
        # Counter to move through the diagonals
        counter = 0
        # Bool to check if match found
        match = false
        # Check both diagonals, stop if match found
        until match == true || counter >= 2 do
            # Declare match found if diagonal has match
            match = true if check_array == @board_grid.get_diagonal_array(counter)
            # Move to other diagonal
            counter += 1
        end
        match
    end

    def set_value (row, column, symbol)
        @board_grid.set_node(row, column, symbol)
    end

    def get_board_array ()
        # nil -> Array
        # Get the board grid as a nested array with
        # each nested array representing a row

        # Store the result array
        result = Array.new()
        # Go through all three rows
        for row in 0..2
            # Add each row to result array
            result.push(@board_grid.get_row_array(row))
        end
        result
    end

    def show_board ()
        # nil -> str
        # Shows the entire board state visually

        # Get the board in array form
        board_array = get_board_array()
        # Create result to store the board string
        # result = "-------------------------------------------------\n" # To format with tabs
        line_string = "-------------------\n"
        result = line_string

        # Go through each row and add values to the string with formatting
        board_array.each do |row|
            result += "|  #{row[0]}  |  #{row[1]}  |  #{row[2]}  |\n"
            result += line_string
        end
        result
    end

end

# main_board = Board.new()

# main_board.set_value(0,0,"b")
# main_board.set_value(0,1,"b")
# main_board.set_value(0,2,"x")
# main_board.set_value(1,0,"y")
# main_board.set_value(1,1,"x")
# main_board.set_value(1,2,"a")
# main_board.set_value(2,0,"a")
# main_board.set_value(2,1,"z")
# main_board.set_value(2,2,"a")

# puts main_board.show_board()