class Puzzle::GreedySolver < Puzzle::PrioritySolver
  def initialize(problem)
    priority = lambda { |graph| graph.problem.manhattan_distance }
    super(problem, priority)
  end
end
