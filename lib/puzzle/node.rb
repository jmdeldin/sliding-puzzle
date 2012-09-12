# Simple linked list for puzzle configurations
class Puzzle::Node
  attr_accessor :problem, :parent, :move

  def initialize(problem, parent=nil, move=nil)
    @parent = parent
    @problem = problem
    @move = move
  end

  def board
    @problem.board.flatten.join
  end
end
