require_relative 'solver'

# Breadth-first search solution
class Puzzle::BfsSolver < Puzzle::Solver
  def initialize(problem)
    super(problem, Containers::Queue.new)
  end
end
