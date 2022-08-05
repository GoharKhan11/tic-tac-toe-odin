class GridNode

    def initialize (value=nil, row=0, column=0, right_node=nil, down_node=nil)
        # any, int, int, GridNode, GridNode
        # Create a node holding initial value
        # row and column is used to show the position in the grid
        # right_node is the node to the right of this node in the grid
        # right_node is the node below this node in the grid

        @value = value
        @row = row
        @column = column
        @right_node = right_node
        @down_node = down_node
    end

    attr_accessor :value
    attr_reader :row
    attr_reader :column
    attr_accessor :right_node
    attr_accessor :down_node


end

class Grid

    def initialize (rows=1, columns=1, default_value=nil)
        @head = create_grid(rows, columns, default_value)
        @grid_rows = rows
        @grid_columns = columns
    end

    attr_reader :grid_rows
    attr_reader :grid_columns

    def create_grid_helper (rows=1, columns=1, default_value=nil)
        # int, int, any -> array
        # Creates a nested array of 2d nodes representing a 2D grid

        # Used to count through the rows (nested arrays) to create
        row_counter = 0
        # Used to count through nodes added to each row
        column_counter = 0
        # Create array to hold result
        result = Array.new()
        # Go through each row to be created
        while row_counter < rows do
            # Reset column count for new row
            column_counter = 0
            # Adds new nested array (new row)
            result.push(Array.new())
            # Adds a node to the row for each column
            while column_counter < columns do
                result[row_counter].push(GridNode.new(default_value, row_counter, column_counter))
                # result[row_counter].push(GridNode.new("(node_row:#{row_counter};node_column:#{column_counter})", row_counter, column_counter)) # Test line
                column_counter += 1
            end
            # Move to create next nested array (the next row)
            row_counter += 1
        end
        return result
    end


    def create_grid (rows=1, columns=1, default_value=nil)
        # int, int, any -> GridNode
        # Construct actual 2D grid
        # Returns the top left node of the grid

        # Get the 2D array of grid nodes to be linked into a Grid 
        grid_array = create_grid_helper(rows, columns, default_value)
        # Set Node at grid_array[0][0] as the head of the grid (named result as it will be returned)
        result = grid_array[0][0]
        # Iterate through each row in grid_array with index
        grid_array.each_with_index do |row, row_index|
            # Iterate through each entry in each row in grid_array with index
            row.each_with_index do |current_node, column_index|
                # Set the right node value
                # If we are on the right edge of the grid there is no next right node (nil)
                if column_index == (columns - 1)
                    set_right_node = nil
                # Otherwise next right node is next entry in the same row
                else
                    set_right_node = grid_array[row_index][column_index+1]
                end
                # Set the down node value
                # If we are on the bottom edge of the grid there is no next down node (nil)
                if row_index == (rows - 1)
                    set_down_node = nil
                # Otherwise next down node is same entry index in the next row
                else
                    set_down_node = grid_array[row_index+1][column_index]
                end
                # Set the neighbouring nodes for current_node unless values are nil
                current_node.right_node = set_right_node unless set_right_node == nil
                current_node.down_node = set_down_node unless set_down_node == nil
            end
        end
        return result
    end

    def get_row (row_number)
        # int -> array
        # Returns the intiial node in the desired row

        # Returns error message if the desired row is invalid
        if row_number >= @grid_rows
            return "Row number is invalid, this grid has #{@grid_rows} rows. Index starts at 0."
        end

        # Sets initial node as the head of the grid
        current_node = @head

        # Moves down till the left most node of the desired row is reached
        until current_node.row == row_number do
            current_node = current_node.down_node
        end
        current_node
    end

    def get_row_array (row_number)
        # int -> array
        # Returns all values in the desired row of the grid in an array

        # Get the initial node in the row (or error message if row_number is invalid)
        current_node = get_row(row_number)
        # Return the error message if raised
        if current_node.class == String
            return current_node
        end

        # Creates result array
        result = Array.new()

        # Moves through the row until a nil item is reached (meaning no more nodes in the row)
        until current_node == nil do
            # Enter value of each node in the row
            result.push(current_node.value)
            # Move to next node in the row
            current_node = current_node.right_node
        end
        result
    end

    def get_column (column_number)
        # int -> array
        # Returns the intiial node in the desired row

        # Returns error message if the desired column is invalid
        if column_number >= @grid_columns
            return "Column number is invalid, this grid has #{@grid_columns} columns. Index starts at 0."
        end

        # Sets initial node as the head of the grid
        current_node = @head

        # Moves right till the top most node of the desired column is reached
        until current_node.column == column_number do
            current_node = current_node.right_node
        end
        current_node
    end

    def get_column_array (column_number)
        # int -> array
        # Returns all values in the desired column of the grid in an array

        # Get the initial node in the column (or error message if row_number is invalid)
        current_node = get_column(column_number)
        # Return the error message if raised
        if current_node.class == String
            return current_node
        end

        # Creates result array 
        result = Array.new()

        # Moves through the column until a nil item is reached (meaning no more nodes in the column)
        until current_node == nil do
            # Enter value of each node in the column
            result.push(current_node.value)
            # Move to next node in the column
            current_node = current_node.down_node
        end
        result
    end

    def get_node (row_number, column_number)
        # int, int -> nil
        # Returns the desired grid node

        # Move to desired row
        current_node = get_row(row_number)
        # Move along the row till desired node is reached
        until current_node.column == column_number
            current_node = current_node.right_node
        end
        current_node
    end


    def set_node (row_number, column_number, new_value)
        # int, int, any -> nil
        # Changes the value in the desired grid node

        # Get desired node
        current_node = get_node(row_number, column_number)
        # Change value
        current_node.value = new_value
    end

    def get_diagonal_array (diagonal_type)
        # int -> array

        # Return error message if the grid is not square
        return "The grid is not square" unless @grid_rows == @grid_columns
        # Starts at head node of grid
        current_node = @head
        # Creates a result array
        result = Array.new()

        # If the main diagonal from top-left to bottom-right is desired
        if diagonal_type == 0
            # Goes across the diagonal till nil is encountered (meaning no more nodes in the diagonal)
            until current_node == nil do
                # Add value of current node to result
                result.push(current_node.value)
                # Move right
                current_node = current_node.right_node
                # Move down unless nil has been encountered
                current_node = current_node.down_node unless current_node == nil
            end
        # if the secondary diagonal from top-right to bottom-left is desired
        elsif diagonal_type == 1
            # Stores all nodes in the top of each column in an array
            column_array = Array.new()
            current_node = @head
            # Adds each column head node to the start of column_array
            until current_node == nil do
                column_array.unshift(current_node)
                current_node = current_node.right_node
            end
            counter = 0
            column_array.each do |column_node|
                current_node = column_node
                counter.times { |index| current_node = current_node.down_node }
                result.push(current_node.value)
                counter += 1
            end

        # If neither valid daigonal has been selected
        else
            result = "Not a valid diagonal type"
        end
        result
    end

end

# Test setup
# main_grid = Grid.new(3, 3)

# Test for create_grid_helper method
# grid_array = main_grid.create_grid_helper(3,4)
# grid_array.each_with_index do |row, row_index|
#     row.each_with_index do |entry, column_index|
#         puts "Node at row #{row_index} and column #{column_index}: #{entry.value}"
#     end
# end

# main_grid.set_node(2, 1, "banana")
# puts "Row Test:"
# puts main_grid.get_row_array(2)
# puts "Column Test:"
# puts main_grid.get_column_array(1)
# main_node = main_grid.get_node(2, 3)
# puts "node row: #{main_node.row} and node column: #{main_node.column}"
# puts "Main diagonal Test:"
# puts main_grid.get_diagonal_array(0)
# puts "Secondary diagonal Test:"
# puts main_grid.get_diagonal_array(1)
