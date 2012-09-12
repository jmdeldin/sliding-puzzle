class Puzzle::DfsSolver < Puzzle::Solver
  def initialize(problem)
    super(problem, Containers::Stack.new)
  end
end
