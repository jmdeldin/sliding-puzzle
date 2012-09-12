require_relative 'solver'

class Puzzle::DfsSolver < Puzzle::Solver
  def run(problem)
    g = Puzzle::Node.new(problem)
    frontier = []
    frontier.unshift g
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
          frontier.unshift new_graph
        end
      end
    end
  end
end
