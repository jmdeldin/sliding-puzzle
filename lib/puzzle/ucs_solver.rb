require_relative 'priority_solver'

class Puzzle::UcsSolver < Puzzle::PrioritySolver
  def initialize(problem)
    priority = lambda { |graph| graph.cost }
    super(problem, priority)
  end
end
