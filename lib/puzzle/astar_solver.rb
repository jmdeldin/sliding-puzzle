require_relative 'priority_solver'

class Puzzle::AstarSolver < Puzzle::PrioritySolver
  def initialize(problem, heuristic)
    priority = lambda { |graph| graph.problem.send(heuristic) + graph.cost }
    super(problem, priority)
  end
end
