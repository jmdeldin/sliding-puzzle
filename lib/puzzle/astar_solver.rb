require_relative 'solver'
require 'algorithms'

class Puzzle::AstarSolver < Puzzle::Solver
  def initialize(problem, heuristic)
    @heuristic = heuristic
    super(problem)
  end

  def run(problem)
    g = Puzzle::Node.new(problem)
    frontier = Containers::PriorityQueue.new do |x, y|
      (y <=> x) == 1 # prefer smaller elts
    end

    frontier.push(g, g.problem.send(@heuristic) + g.cost)
    marked = {g.board => true}

    until frontier.empty?
      ng = frontier.pop

      return @solution = ng if ng.problem.solved?
      @counts += 1
      progress_report

      # for every action, create some separate graphs
      ng.problem.actions.each do |action|
        new_problem = ng.problem.clone
        new_problem.move(action)
        new_graph = Puzzle::Node.new(new_problem, ng)
        new_graph.move = action

        if !marked[new_graph.board]
          marked[new_graph.board] = true
          frontier.push(new_graph, new_graph.problem.send(@heuristic) + new_graph.cost)
        end
      end
    end
  end
end
