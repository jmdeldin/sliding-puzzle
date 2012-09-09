class Puzzle::Problem
  attr_reader :m, :n, :board, :path_cost

  def initialize(opts={})
    @board = opts.fetch(:board)

    @rows = @m = @board.size
    @cols = @n = @board.first.size
    @blank_position = find_blank_position
    @path_cost = 0
  end

  # Automatically determines the goal state given the dimensions of a board.
  #
  def goal_state
    return @goal_state if @goal_state

    tiles = (1...@rows*@cols).to_a << 0
    @goal_state = tiles.each_slice(@cols).to_a
  end

  # This is the goal test method that compares the current board state to the
  # goal state.
  def solved?
    return false unless @board[-1][-1] == 0
    @board == goal_state
  end

  def actions
    actions = [:up, :down, :left, :right]
    x, y = @blank_position

    if x == 0
      actions.delete :left
    elsif x == @cols - 1
      actions.delete :right
    end

    if y == 0
      actions.delete :up
    elsif y == @rows - 1
      actions.delete :down
    end

    actions
  end

  def move(direction)
    fail "Move #{direction} not permitted" unless actions.include?(direction)

    send(direction)
    @path_cost += 1
  end

  def print_board
    s = ''
    @board.each do |row|
      row.each do |tile|
        s << "%2d " % tile
      end
      s << "\n"
    end
    s
  end

  # TODO: Solvable by counting inversions -- fail in initializer
  private

  def find_blank_position
    @board.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        return [j, i] if tile == 0
      end
    end
  end

  def right
    x0, y = @blank_position
    slide_x(x0, x0+1, y)
    @blank_position[0] += 1
  end

  def left
    x0, y = @blank_position
    slide_x(x0, x0-1, y)
    @blank_position[0] -= 1
  end

  def up
    x, y0 = @blank_position
    slide_y(y0, y0-1, x)
    @blank_position[1] -= 1
  end

  def down
    x, y0 = @blank_position
    slide_y(y0, y0+1, x)
    @blank_position[1] += 1
  end

  def slide_x(x0, x1, y)
    swap(x0, y, x1, y)
  end

  def slide_y(y0, y1, x)
    swap(x, y0, x, y1)
  end

  def swap(x0, y0, x1, y1)
    tmp = @board[y0][x0]
    @board[y0][x0] = @board[y1][x1]
    @board[y1][x1] = tmp
  end
end
